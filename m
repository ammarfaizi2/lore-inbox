Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbTDVIYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 04:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbTDVIYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 04:24:42 -0400
Received: from [80.190.48.67] ([80.190.48.67]:47364 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263018AbTDVIYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 04:24:42 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: eric.valette@free.fr, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc1 : aic7xxx deadlock on boot on my machine
Date: Tue, 22 Apr 2003 10:36:19 +0200
User-Agent: KMail/1.5.1
References: <3EA4FF4C.2030702@free.fr>
In-Reply-To: <3EA4FF4C.2030702@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304221036.19274.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 April 2003 10:37, Eric Valette wrote:

Hi Eric,

> I just wants to point out on this list that since pre7 (or using
> pre4-acxx), I boot once out of two on my dual adaptec scsi machine.
> The good news is that upgrading to more recent aic7xxx drivers fixes the
> problemas indeed the locking strategy has been changed... BTW, 2.5.68
> includes the new code also.
> So I hope, it will be updated in rc2...
I'll _bet_ that the new well good code from Justin won't make it into 2.4 
earlier than 2.4.22-pre1.

ciao, Marc
