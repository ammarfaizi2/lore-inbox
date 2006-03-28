Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWC1PNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWC1PNb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 10:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWC1PNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 10:13:31 -0500
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:7248 "HELO
	web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750976AbWC1PNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 10:13:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Z/Cv6bjsMwDGKRkk8ML/XC0zmm7UT18EfPYkNlGcFIaaThmcObTUsn8dS9g68HDWZh1Hup78cvqmXiPdDKHO9Ixw7SaWIfBxgZ3PCi8lVtrW3XXyAtjEkiVT1d2tVzg3d8+Xt9RFQLjWWOcee1pTmmqtDmYweQXzZXa5Nc4FIvE=  ;
Message-ID: <20060328151328.53672.qmail@web31811.mail.mud.yahoo.com>
Date: Tue, 28 Mar 2006 07:13:28 -0800 (PST)
From: cyber rigger <cyber_rigger@yahoo.com>
Subject: Need help reporting bug, no 3D accel with Matrox g400
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need help reporting a bug.


It appears that some later kernel versions
do not support 3D acceleration in some cases.
I'm getting this problem with Debain etch and Ubuntu
Dapper. I first thought it was a problem caused by
switching to xorg but Ubuntu 5.10 is fine and it uses
xorg. 

----------------------------------------------------
The 3D acceleration doesn't work with xorg using the
mga driver for a Matrox g400.
My test case is ppracer which runs dreadfully slow.

This is a Debian etch machine with Debian's 
2.6.15-1-k7 kernel.


This is what I have found so far.

Re: No direct rendering with recent kernels
http://lists.debian.org/debian-x/2006/01/msg00133.html[mga]


DRM for MGA broken since 2005-Aug-04.
https://bugs.freedesktop.org/show_bug.cgi?id=4797



The 3D acceleration for mga appears to still be
broken.

Where and how may I respectfully plead for this to be
fixed?

:^)


Thanks




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
