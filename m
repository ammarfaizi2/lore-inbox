Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbUL2VxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbUL2VxK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 16:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUL2VxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 16:53:10 -0500
Received: from quechua.inka.de ([193.197.184.2]:16775 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261428AbUL2VxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 16:53:08 -0500
From: Bernd Eckenfels <ecki-news2004-12@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: waiting 10s before mounting root filesystem?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20041229205940.GB3024@node1.opengeometry.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1Cjlkg-0007zZ-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 29 Dec 2004 22:53:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20041229205940.GB3024@node1.opengeometry.net> you wrote:
> I finally wrote a script to build 200MB root filesystem from Slackware
> distribution (A, AP, N, X series).  And, now, you're telling me to build
> a 200kB root filesystem?  I need beer...

You only need to have the one executable file and supporting files like
config files, shells or libs. In case of a static compiled script you need
no libs nor shell. You will probably need some mount and usb tools, not more.


Bernd
