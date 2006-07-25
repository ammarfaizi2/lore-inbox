Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWGYXLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWGYXLa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWGYXLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:11:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:30890 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030243AbWGYXL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:11:29 -0400
Date: Tue, 25 Jul 2006 18:10:40 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: VIA x86-64 bootlogs needed
Message-ID: <20060725231039.GA25240@us.ibm.com>
References: <200607251824.30504.ak@suse.de> <200607252158.04254.bonganilinux@mweb.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607252158.04254.bonganilinux@mweb.co.za>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 09:58:04PM +0200, Bongani Hlope wrote:
> On Tuesday 25 July 2006 18:24, Andi Kleen wrote:
> > Hi,
> >
> > For some APIC code rework I would like to collect some statistics on
> > VIA APIC setups.
> >
> > If you have a system with VIA chipset running a recent (2.6.16+) x86-64
> > kernel please boot the system with apic=verbose on the kernel command and
> > send me
> >
> > - boot output (/var/log/boot.msg or dmesg -s100000000 output after boot)
> > - dmidecode output
> > - lspci  -v output
> >
> > Thanks,
> >
> >
> 
> This is a MSI  K8T Master2 FAR with the  VIA? K8T800 + 8237 chipset, kernel 
> 2.6.17-mm1
> 

I have the same mobo running latest 2.6.18.  Let me know if you need my
info too.

Thanks,
Jon
