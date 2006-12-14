Return-Path: <linux-kernel-owner+w=401wt.eu-S1751817AbWLNR5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbWLNR5Z (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbWLNR5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:57:25 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:32917 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbWLNR5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:57:24 -0500
Date: Thu, 14 Dec 2006 18:57:01 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?iso-8859-15?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <200612141817.22741.hjk@linutronix.de>
Message-ID: <Pine.LNX.4.61.0612141855420.12730@yvahk01.tjqt.qr>
References: <20061213195226.GA6736@kroah.com> <200612141056.03538.hjk@linutronix.de>
 <Pine.LNX.4.61.0612141756110.12730@yvahk01.tjqt.qr> <200612141817.22741.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-45606630-1166119021=:12730"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-45606630-1166119021=:12730
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Dec 14 2006 18:17, Hans-Jürgen Koch wrote:
>> 
>> They use floating point in (Windows) kernelspace? Oh my.
>
>To be honest, I never really understood where kernel space starts and user space
>ends in Windows, so I'm not sure about this :-)

Well, in Windows 95/98 you could do inportb (inb) and friends from "userspace"
without an extra kernel driver. Maybe it just always ran in kernelspace,
explains why many say 95/98 was less stable than the NT-based versions.

	-`J'
-- 
--1283855629-45606630-1166119021=:12730--
