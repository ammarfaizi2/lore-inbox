Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTLSIzC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 03:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTLSIzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 03:55:02 -0500
Received: from grebe.mail.pas.earthlink.net ([207.217.120.46]:7863 "EHLO
	grebe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262139AbTLSIzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 03:55:00 -0500
Date: Fri, 19 Dec 2003 03:54:39 -0500
To: hunold@convergence.de, schwientek@web.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test11 framebuffer Matrox
Message-ID: <20031219085439.GA16598@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My Matrox-framebuffer is not working properly.

ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.6.0-test7.gz
applies to 2.6.0 cleanly and works beautifully with my G400.  You have
to change your video=matrox boot command to video=matroxfb for 2.6.
-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

