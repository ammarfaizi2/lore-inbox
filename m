Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932752AbVINSX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbVINSX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932751AbVINSX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:23:56 -0400
Received: from er-systems.de ([217.172.180.163]:50948 "EHLO er-systems.de")
	by vger.kernel.org with ESMTP id S932750AbVINSX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:23:56 -0400
Date: Wed, 14 Sep 2005 20:23:58 +0200 (CEST)
From: Thomas Voegtle <tv@lio96.de>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB digital camera erroneously says "no medium found"
In-Reply-To: <20050909091502.GB27699@kestrel>
Message-ID: <Pine.LNX.4.61.0509142020500.22437@er-systems.de>
References: <20050909091502.GB27699@kestrel>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1395022924-987365614-1126722238=:22437"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1395022924-987365614-1126722238=:22437
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 9 Sep 2005, Karel Kulhavy wrote:

> Hello
> 
> I have Nikon Coolpix 2000 digital camera which was working well on my
> old Linux 2.6.? machine. After moving to a different one while the old
> one is not accessible, where the new one has Linux version 2.6.13, I
> found it doesn't work anymore. When compact flash is inside the camera,
> camera turned on and connected, cat /dev/sda says no media found.  cat
> /dev/sdb, /dev/sdc, /dev/sdd say no such file or directory.
> 

I have the same camera and long time ago I found this mail:

http://www.mail-archive.com/linux-usb-users@lists.sourceforge.net/msg12504.html


This worked for me. Please try it out.



      Thomas

-- 
 Thomas Vögtle    email: thomas@voegtle-clan.de
 ----- http://www.voegtle-clan.de/thomas ------
---1395022924-987365614-1126722238=:22437--
