Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282511AbSAMJvT>; Sun, 13 Jan 2002 04:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282845AbSAMJvL>; Sun, 13 Jan 2002 04:51:11 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:9625 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S282511AbSAMJvD>; Sun, 13 Jan 2002 04:51:03 -0500
Date: Sun, 13 Jan 2002 11:50:19 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <Tony.Glader@blueberrysolutions.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: F00F-bug workaround working? 
Message-ID: <Pine.LNX.4.33.0201131148500.28980-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The F00F bug locks up your box, the oopses have nothing to do with it. If
the box is still alive after the oops try running ksymoops on them. If you
notice that its a different oops each time, its probably your hardware
going round the bend.

Cheers,
	Zwane Mwaikambo


