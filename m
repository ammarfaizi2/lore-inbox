Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263113AbVGNTFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbVGNTFt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVGNTFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:05:38 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:55716 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S263113AbVGNTEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:04:33 -0400
Date: Thu, 14 Jul 2005 13:04:26 -0600 (MDT)
From: "Ronald G. Minnich" <rminnich@lanl.gov>
To: Andi Kleen <ak@suse.de>
cc: Li-Ta Lo <ollie@lanl.gov>, yhlu <yinghailu@gmail.com>,
       Stefan Reinauer <stepan@openbios.org>, discuss@x86-64.org,
       LinuxBIOS <linuxbios@openbios.org>, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [LinuxBIOS] NUMA support for dual core Opteron
In-Reply-To: <20050714184821.GJ23619@wotan.suse.de>
Message-ID: <Pine.LNX.4.58.0507141303210.22630@enigma.lanl.gov>
References: <2ea3fae10507141058c476927@mail.gmail.com>
 <1121365786.3317.6.camel@logarithm.lanl.gov> <20050714184821.GJ23619@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jul 2005, Andi Kleen wrote:

> However you'll likely need ACPI for other reasons anyways, e.g. for
> better power saving.

bummer. What the BIOS vendors are doing (to lock in proprietary BIOS, some
say)  is making ACPI tables copyright the BIOS vendor, not the motherboard 
vendor. So LinuxBIOS will have to reverse engineer their own, somehow. 

Shame we can't free ourselves of ACIP a bit. Oh well.

ron
