Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291664AbSBNOEm>; Thu, 14 Feb 2002 09:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291665AbSBNOEc>; Thu, 14 Feb 2002 09:04:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65298 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291664AbSBNOEX>; Thu, 14 Feb 2002 09:04:23 -0500
Subject: Re: Using kernel_fpu_begin() in device driver - feasible or not?
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 14 Feb 2002 14:18:20 +0000 (GMT)
Cc: rwestman@telia.com (Rickard Westman), linux-kernel@vger.kernel.org
In-Reply-To: <E16bMEO-0008Up-00@the-village.bc.nu> from "Alan Cox" at Feb 14, 2002 01:47:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bMiK-00008R-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > kernel_fpu_begin()/kernel_fpu_end()?  If not, what problems could I
> > run into?
> 
> You can do that providing you dont

Umm that wasn't me trying to be zen. I meant "you dont sleep"
