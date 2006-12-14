Return-Path: <linux-kernel-owner+w=401wt.eu-S1750915AbWLNRCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWLNRCh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWLNRCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:02:37 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:48500 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbWLNRCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:02:36 -0500
Date: Thu, 14 Dec 2006 18:02:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <200612141056.03538.hjk@linutronix.de>
Message-ID: <Pine.LNX.4.61.0612141756110.12730@yvahk01.tjqt.qr>
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org>
 <200612140949.43270.duncan.sands@math.u-psud.fr> <200612141056.03538.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-770086369-1166115734=:12730"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-770086369-1166115734=:12730
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Dec 14 2006 10:56, Hans-Jürgen Koch wrote:
>
>A small German manufacturer produces high-end AD converter cards. He sells
>100 pieces per year, only in Germany and only with Windows drivers. He would
>now like to make his cards work with Linux. He has two driver programmers
>with little experience in writing Linux kernel drivers. What do you tell him?
>Write a large kernel module from scratch? Completely rewrite his code 
>because it uses floating point arithmetics?

They use floating point in (Windows) kernelspace? Oh my.


	-`J'
-- 
--1283855629-770086369-1166115734=:12730--
