Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSHOOJi>; Thu, 15 Aug 2002 10:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316996AbSHOOJi>; Thu, 15 Aug 2002 10:09:38 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:11526 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S316971AbSHOOJh>; Thu, 15 Aug 2002 10:09:37 -0400
Date: Thu, 15 Aug 2002 08:13:06 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: zhengchuanbo <zhengcb@netpower.com.cn>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: problem with Adaptec aic7899 in linux2.4
Message-ID: <2222740000.1029420786@aslan.scsiguy.com>
In-Reply-To: <200208152016307.SM00808@zhengcb>
References: <200208152016307.SM00808@zhengcb>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i met a problem with the scsi disk on linux2.4.19-pre1.
> during the boot of the system,the following messages were displayed,
> 
> (scsi:A:15:0): Unexpected busfree while idle
> scsi: <fdomain> Detection failed (no card)
> sys53c416.c: Version 1.0.0-ac
> 
> then the system hang the. we use adaptec aic7899. 
> btw,the same system worked on another machine with the same type of scsi
> disk. so what's the problem?
> please cc.thanks.

It would help to have more information about the system and the peripherals
attached to it.  A dmesg would do that.

--
Justin

