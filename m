Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWEPPOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWEPPOV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWEPPOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:14:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:22183 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932079AbWEPPOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:14:20 -0400
X-Authenticated: #13243522
Message-ID: <4469EC4A.30908@gmx.de>
Date: Tue, 16 May 2006 17:14:18 +0200
From: Michael Schierl <schierlm@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
References: <20060512132437.GB4219@htj.dyndns.org> <e4coc8$onk$1@sea.gmane.org> <4469E8CF.9030506@garzik.org>
In-Reply-To: <4469E8CF.9030506@garzik.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=58B48CDD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik schrieb:
> Michael Schierl wrote:
> 
>> On Fri, 12 May 2006 22:24:37 +0900, Tejun Heo wrote:
>>
>>> ahci:        new EH, irq-pio, NCQ, hotplug
>>
>> Should suspend-to-RAM work now on AHCI?
> 
> It probably still needs Hannes' AHCI patch, and possibly the SATA ACPI
> patches too.

hmm. ok. Hannes' patch was the one in http://lkml.org/lkml/2006/3/6/47 ?

I never found a kernel where I could apply that one and still compile
without errors :(

I am no C guru, so I had no success to fix this patch without even
knowing where to apply against... (and I don't know anything about
kernel programming or even ACHI low-level programming).

Is there a newer version available of that patch somewhere?

And - what SATA ACPI patches?

I have quite alot of patches related to sata and/or acpi (collected from
different mailing lists) here on hard disk but don't know which ones are
broken, outdated, etc. Most only apply on a 2.6.15 or 2.6.14-rc kernel...

If more recent patches are only available via git, I'd need some good
GIT tutorial first...

TIA, and sorry for stealing your time,

Michael
