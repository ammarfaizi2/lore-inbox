Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSGaLfu>; Wed, 31 Jul 2002 07:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSGaLfu>; Wed, 31 Jul 2002 07:35:50 -0400
Received: from ns.sysgo.de ([213.68.67.98]:9209 "EHLO dagobert.svc.sysgo.de")
	by vger.kernel.org with ESMTP id <S316204AbSGaLfu>;
	Wed, 31 Jul 2002 07:35:50 -0400
Date: Wed, 31 Jul 2002 13:36:18 +0200
From: Soewono Effendi <SEffendi@sysgo.de>
To: "Mikael Pettersson" <mikpe@csd.uu.se>
Cc: linux-kernel mlist <linux-kernel@vger.kernel.org>
Subject: Re: initial ramdisk + devfs
Message-Id: <20020731133618.5114996b.SEffendi@sysgo.de>
In-Reply-To: <15687.48191.182139.642836@kim.it.uu.se>
References: <20020731112826.61a75ece.SEffendi@sysgo.de>
	<15687.48191.182139.642836@kim.it.uu.se>
Organization: SYSGO Real-Time Solutions GmbH
X-Mailer: Sylpheed version 0.7.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2002 12:30:23 +0200
"Mikael Pettersson" <mikpe@csd.uu.se> wrote:

> The floppy driver has been mostly broken since 2.5.13, which you would
> have known had you bothered to read LKML or search the LKML archives.
> The problem has been reported many times.

Thanks for your information. Did that, and found your patch.
Tried it, but no luck ;( (as noted in your README.txt)

Nevertheless, this idea:
>> Maybe there should be a kind of separate "WARNING_API_CHANGED" file under 
 Documentation, so that everybody might keep up with the latest "What might 
 be broken now?".
 
might reduce "noises" in LKML and might save bits and bandwidth.


Best regards,
-- 
>> S. Effendi                              SEffendi @ sysgo . de
SYSGO Real-Time Solutions GmbH             http://www.sysgo.de
Am Pfaffenstein 14                         Tel. +49 6136 99 48 0
55270 Klein-Winternheim - Germany          Fax. +49 6136 99 48 10
