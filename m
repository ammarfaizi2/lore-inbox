Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317731AbSGKCgY>; Wed, 10 Jul 2002 22:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317735AbSGKCgX>; Wed, 10 Jul 2002 22:36:23 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:3369 "EHLO devil.stev.org")
	by vger.kernel.org with ESMTP id <S317731AbSGKCgW>;
	Wed, 10 Jul 2002 22:36:22 -0400
Message-ID: <006201c22883$cfa85ea0$0501a8c0@Stev.org>
From: "James Stevenson" <mistral@stev.org>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
References: <000901c226ac$dec99b20$0501a8c0@Stev.org>
Subject: Re: ATAPI + cdwriter problem
Date: Thu, 11 Jul 2002 03:36:50 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

i have come across the following options in the 2.4.19-rc1 config
would these makes any difference to the timeouts i am seeing with the
promise controller ?
and are they safe to enable ?

CONFIG_IDEDMA_PCI_WIP
CONFIG_BLK_DEV_IDEDMA_TIMEOUT
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS


>
> thanks
>     James
>
> --------------------------
> Mobile: +44 07779080838
> http://www.stev.org
>   7:10pm  up 57 min,  3 users,  load average: 2.05, 1.84, 1.10
>



