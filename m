Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTLaImP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 03:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbTLaImP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 03:42:15 -0500
Received: from mail1.speakeasy.net ([216.254.0.201]:44712 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S262386AbTLaImN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 03:42:13 -0500
Message-Id: <6.0.1.1.0.20031231003359.024626f0@no.incoming.mail>
X-Mailer: QUALCOMM Windows Eudora Version 6.0.1.1
Date: Wed, 31 Dec 2003 00:40:10 -0800
To: Jeff Garzik <jgarzik@pobox.com>
From: Jeff Woods <kazrak+kernel@cesmail.net>
Subject: Re: ICH5 docs
Cc: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <3FF1B43A.9090707@pobox.com>
References: <20031230164953.GB4868@atrey.karlin.mff.cuni.cz>
 <3FF1B43A.9090707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12/30/2003 12:22 PM -0500, Jeff Garzik wrote to linux-kernel:
>Karel Kulhavy wrote:
>>Where can I learn about ICH5 SATA RAID driver in Linux kernel 2.6.0?  I
>
>Intel "RAID" is software RAID.  There isn't any hardware RAID assist...
>So ICH5 looks pretty much just like any other PATA host controller.

Oh?  My understanding (which I admit is very high-level) is that Intel's 
ICH5 southbridge supports SATA; but to get SATA+RAID requires the ICH5R 
southbridge.  If not, what are the practical differences (if any) between 
the ICH5 and ICH5R?

TIA.

--
Jeff Woods <kazrak+kernel@cesmail.net> 


