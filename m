Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262693AbTDARif>; Tue, 1 Apr 2003 12:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262694AbTDARif>; Tue, 1 Apr 2003 12:38:35 -0500
Received: from 84e5e703.math.leidenuniv.nl ([132.229.231.3]:38033 "EHLO
	zada.math.leidenuniv.nl") by vger.kernel.org with ESMTP
	id <S262693AbTDARie>; Tue, 1 Apr 2003 12:38:34 -0500
Date: Tue, 1 Apr 2003 19:49:04 +0200
From: Lennert Buytenhek <buytenh@math.leidenuniv.nl>
To: linux-kernel@vger.kernel.org, davide@xmailserver.org
Subject: [ANNOUNCE] libivykis 0.2, fd event handling library
Message-ID: <20030401174904.GA29065@math.leidenuniv.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://sourceforge.net/projects/libivykis/

libivykis is a thin wrapper over various OS'es implementation of
I/O readiness notification facilities (such as poll(2), kqueue(2),
epoll_create(2)), and is mainly intended for writing portable
high-performance network servers.

It has so far been used to implement a streaming video server and
proxy servers for various protocols.

This is the first public release.


