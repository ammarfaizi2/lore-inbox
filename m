Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283163AbRLDTEm>; Tue, 4 Dec 2001 14:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283320AbRLDTDR>; Tue, 4 Dec 2001 14:03:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60933 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283282AbRLDTBo>; Tue, 4 Dec 2001 14:01:44 -0500
Subject: Re: Insmod problems
To: apiggyjj@yahoo.ca
Date: Tue, 4 Dec 2001 19:10:10 +0000 (GMT)
Cc: BIRDTY@uvsc.edu (Tyler BIRD), linux-kernel@vger.kernel.org
In-Reply-To: <20011204182023.87068.qmail@web20206.mail.yahoo.com> from "Michael Zhu" at Dec 04, 2001 01:20:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BKxG-000370-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've changed my source file like this:
> #define MODULE
> 
> #include <linux/module.h>

Is your kernel configured with module versioning ?

