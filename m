Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWD0HEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWD0HEg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 03:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWD0HEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 03:04:36 -0400
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:30222 "EHLO
	smtp-vbr12.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751374AbWD0HEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 03:04:35 -0400
Date: Thu, 27 Apr 2006 09:04:25 +0200
From: bjdouma <bjdouma@xs4all.nl>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: two additions to ./linux/Documentation/ioctl-number.txt
Message-ID: <20060427070425.GA4892@skyscraper.unix9.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Disclaimer: sorry
X-Operating-System: human brain v1.04E11
Organization: A training zoo
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- ./linux/Documentation/ioctl-number.txt.orig	2006-01-04 03:04:44.000000000 +0100
+++ ./linux/Documentation/ioctl-number.txt	2006-04-27 08:58:29.000000000 +0200
@@ -87,7 +87,9 @@ Code	Seq#	Include File		Comments
 					<mailto:maassen@uni-freiburg.de>
 'C'	all	linux/soundcard.h
 'D'	all	asm-s390/dasd.h
+'E'	all	linux/input.h
 'F'	all	linux/fb.h
+'H'	all	linux/hiddev.h
 'I'	all	linux/isdn.h
 'J'	00-1F	drivers/scsi/gdth_ioctl.h
 'K'	all	linux/kd.h

Nothing new, they just weren't present.
The list may still not be complete.

Regards,

Bauke Jan Douma

