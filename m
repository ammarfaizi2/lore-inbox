Return-Path: <linux-kernel-owner+w=401wt.eu-S932870AbWLNRRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870AbWLNRRZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932872AbWLNRRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:17:25 -0500
Received: from www.osadl.org ([213.239.205.134]:56017 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932870AbWLNRRZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:17:25 -0500
From: =?iso-8859-15?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Organization: Linutronix
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Date: Thu, 14 Dec 2006 18:17:22 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061213195226.GA6736@kroah.com> <200612141056.03538.hjk@linutronix.de> <Pine.LNX.4.61.0612141756110.12730@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612141756110.12730@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612141817.22741.hjk@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Dezember 2006 18:02 schrieb Jan Engelhardt:
> 
> On Dec 14 2006 10:56, Hans-Jürgen Koch wrote:
> >
> >A small German manufacturer produces high-end AD converter cards. He sells
> >100 pieces per year, only in Germany and only with Windows drivers. He would
> >now like to make his cards work with Linux. He has two driver programmers
> >with little experience in writing Linux kernel drivers. What do you tell him?
> >Write a large kernel module from scratch? Completely rewrite his code 
> >because it uses floating point arithmetics?
> 
> They use floating point in (Windows) kernelspace? Oh my.

To be honest, I never really understood where kernel space starts and user space
ends in Windows, so I'm not sure about this :-)

Hans

