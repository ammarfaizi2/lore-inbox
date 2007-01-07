Return-Path: <linux-kernel-owner+w=401wt.eu-S932341AbXAGCVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbXAGCVw (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbXAGCVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:21:52 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:54540 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932341AbXAGCVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:21:51 -0500
Date: Sun, 7 Jan 2007 03:21:00 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>
Subject: sonypi not for 64bit?
Message-ID: <Pine.LNX.4.61.0701070313510.23016@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi sonypi (ex-)maintainers ;-)


drivers/char/Kconfig lists SONYPI as being !64BIT, however, there seem 
to be sony users with x86_64 [1] around. Is it just caution (it's also 
marked EXPERIMENTAL) or is it definitely known to break on 64bit?

	-`J'

[1] (a german forum) http://www.linux-club.de/viewtopic.php?t=74400&highlight=sonypi
