Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVBWP1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVBWP1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 10:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVBWP1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 10:27:14 -0500
Received: from leithammel.gnuher.de ([217.160.128.103]:50138 "EHLO
	leithammel.gnuher.de") by vger.kernel.org with ESMTP
	id S261190AbVBWP1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 10:27:06 -0500
To: linux-kernel@vger.kernel.org
Path: news.geggus.net!not-for-mail
From: Sven Geggus <sven@geggus.net>
Subject: xfsdump broken with Kernel 2.6.11-rc4
Date: Wed, 23 Feb 2005 16:26:58 +0100 (CET)
Organization: Geggus clan, virtual section
Message-ID: <cvi7c2$a3o$1@benzin.geggus.net>
NNTP-Posting-Host: ::1
X-Trace: benzin.geggus.net 1109172418 10361 ::1 (23 Feb 2005 15:26:58 GMT)
X-Complaints-To: usenet@geggus.net
NNTP-Posting-Date: Wed, 23 Feb 2005 15:26:58 +0000 (UTC)
X-TERMINAL: rxvt
X-OS: Debian GNU/Linux (Kernel 2.4.29-exsh-acl)
User-Agent: tin/1.7.5-20040326 ("Benbecula") (UNIX) (Linux/2.4.29-exsh-acl (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

looks like xfsdumpis broken with recent 2.6.11-rc Kernels. 2.6.11-rc4 is the
one I tried.

Strange enough ist does seem to work _sometimes_, but it does not work
most of the time.

If it does not work I just get the following message:

xfsdump: ERROR: /dev/sda2 does not identify a file system

I'm using Version 2.2.23 from debian sarge.

It seems to always work with the Distribution Kernel from Debian sarge.

Sven

-- 
"If you continue running Windows, your system may become unstable."
(Windows 95 BSOD)

/me is giggls@ircnet, http://sven.gegg.us/ on the Web
