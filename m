Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVGEEFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVGEEFJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 00:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVGEEFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 00:05:09 -0400
Received: from mail.harcroschem.com ([208.188.194.242]:22029 "EHLO
	kcdc1.harcros.com") by vger.kernel.org with ESMTP id S261767AbVGEEE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 00:04:59 -0400
Message-ID: <D9A1161581BD7541BC59D143B4A06294021FAAB1@KCDC1>
From: "Hodle, Brian" <BHodle@harcroschem.com>
To: "'Sean Bruno'" <sean.bruno@dsl-only.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: ASUS K8N-DL Beta BIOS
Date: Mon, 4 Jul 2005 23:00:07 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I actually removed the AGP bus completley from the kernel config and
recompiled, this removes the error, and saves you 64mb of ram.

-Brian

-----Original Message-----
From: Sean Bruno [mailto:sean.bruno@dsl-only.net]
Sent: Monday, July 04, 2005 4:39 PM
To: Andi Kleen
Cc: Alexander Nyberg; Alistair John Strachan; Hodle, Brian;
'linux-kernel@vger.kernel.org'; 'ipsoa@posiden.hopto.org'
Subject: Re: ASUS K8N-DL Beta BIOS


On Mon, 2005-07-04 at 23:26 +0200, Andi Kleen wrote:
> > 2.6.13-rc1 has some kind of issue with my board due to it's 6GB of RAM.
> > It stops when it discovers that there is no "IOMMU".  Since I don't see
> > anything obvious in the BIOS to activate, I can't boot 2.6.13 at all.
> 
> Full boot log please?
> 
Well, that might take me a while.  Since the system halts at this point,
I will have to whack together a serial cable to redirect the kernel
post.  

Sean

