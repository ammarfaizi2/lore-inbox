Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277105AbRJDD45>; Wed, 3 Oct 2001 23:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277106AbRJDD4q>; Wed, 3 Oct 2001 23:56:46 -0400
Received: from mpdr0.cleveland.oh.ameritech.net ([206.141.223.14]:29655 "EHLO
	mailhost.cle.ameritech.net") by vger.kernel.org with ESMTP
	id <S277105AbRJDD43>; Wed, 3 Oct 2001 23:56:29 -0400
Date: Wed, 3 Oct 2001 23:56:52 -0400 (EDT)
From: Stephen Torri <storri@ameritech.net>
X-X-Sender: <torri@base.torri.linux>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: HTTP problem running v2.4 kernel
Message-ID: <Pine.LNX.4.33.0110032351450.1056-100000@base.torri.linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Has anyone noticed that certain websites that use to load reliable are no
longer accessible? I used to be able to get into www.nvidia.com and now it
doesn't load. The reason I believe this might be a kernel problem is what
happened when I changed on the same system to kernel 2.2.19-7.0.8smp
(RedHat 7.0 kernel). When I switched to that kernel the website loaded
with out problems. Nothing changed on the same. Same software used with
all the kernels I have used.

The kernel version that I have noticed the problem:

2.4.10-ac4
2.4.9-ac16

Not sure if I noticed it on earlier versions. I will check again.

How can I track down the what is really causing the problem.

Stephen
storri@ameritech.net

