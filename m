Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271670AbVBEPrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271670AbVBEPrn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 10:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271683AbVBEPrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 10:47:43 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:24423 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S271670AbVBEPrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 10:47:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=PAuY3I4AQHy+rknYobCqiqqi7uAebBfexEDQ2rh5ETDekKAZhwL+b+IfrVRE5qoh4X3aimHBQ/azbnwTfhcogDstbYcP2+gcQwB7a2DGC/xJAmPoFxLSmvmVMcu+MwIMxPyiF3nfGUtBTjKhEbu1qZYJes7vAWMUUTz3I3jh7ZI=
Message-ID: <9e473391050205074769e4f10@mail.gmail.com>
Date: Sat, 5 Feb 2005 10:47:39 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4204B3C1.80706@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050122134205.GA9354@wsc-gmbh.de> <420367CF.7060206@gmx.net>
	 <20050204163019.GC1290@elf.ucw.cz>
	 <9e4733910502040931955f5a6@mail.gmail.com>
	 <1107569089.8575.35.camel@tyrosine>
	 <9e4733910502041809738017a7@mail.gmail.com>
	 <1107569842.8575.44.camel@tyrosine>
	 <9e47339105020418306a4c2c93@mail.gmail.com>
	 <1107591336.8575.51.camel@tyrosine>
	 <4204B3C1.80706@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Feb 2005 12:53:37 +0100, Ondrej Zary
<linux@rainbow-software.org> wrote:
> I wonder how this can work:
> a motherboard with i815 chipset (integrated VGA), Video BIOS is
> integrated into system BIOS
> a PCI card inserted into one of the PCI slots, configured as primary in
> system BIOS

The info needed to initialize Intel chips is public. The info needed
to initialize most Nvidia and ATI chips is not.

-- 
Jon Smirl
jonsmirl@gmail.com
