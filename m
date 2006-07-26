Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWGZPLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWGZPLx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWGZPLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:11:53 -0400
Received: from relay2.ptmail.sapo.pt ([212.55.154.22]:52717 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1750750AbWGZPLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:11:52 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.3
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, greg@kroah.com, jeff@garzik.org,
       harmon@ksu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <44C77CA6.2050807@gentoo.org>
References: <20060714095233.5678A8B6253@zog.reactivated.net>
	 <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org>
	 <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org>
	 <44BA48A0.2060008@gentoo.org> <20060716183126.GB4483@kroah.com>
	 <20060717003418.GA27166@tuatara.stupidest.org>
	 <20060724214046.1c1b646e.akpm@osdl.org>
	 <1153874577.7559.36.camel@localhost>
	 <1153917954.29975.22.camel@bastov.localdomain>
	 <44C77544.1050205@gentoo.org>
	 <1153922774.4486.7.camel@localhost.localdomain>
	 <44C77CA6.2050807@gentoo.org>
Content-Type: text/plain; charset=utf-8
Date: Wed, 26 Jul 2006 16:11:48 +0100
Message-Id: <1153926708.4905.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 15:31 +0100, Daniel Drake wrote:
> When the systems booted up a usual APIC/ACPI config, the hardware in 
> question did not work. The quirk was not applied here. 

I think you are missing that APIC is disable by bios or/and by kernel,
and the systems run on XT-PIC.
I don't have time to read the reports sorry .

--
Sérgio M. B. 

