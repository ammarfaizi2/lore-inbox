Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSKYMbC>; Mon, 25 Nov 2002 07:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbSKYMbC>; Mon, 25 Nov 2002 07:31:02 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:20206 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263039AbSKYMbB>; Mon, 25 Nov 2002 07:31:01 -0500
Subject: Re: Linux 2.4.20 ACPI
From: Arjan van de Ven <arjanv@redhat.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Adrian Bunk <bunk@fs.tum.de>,
       Ducrot Bruno <poup@poupinou.org>,
       Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20021125121545.GA22915@suse.de>
References: <4.3.2.7.2.20021119134830.00b53680@mail.dns-host.com>
	<20021119130728.GA28759@suse.de> <20021119142731.GF27595@poup.poupinou.org>
	<20021119164550.GQ11952@fs.tum.de> <20021123195720.GA310@elf.ucw.cz> 
	<20021125121545.GA22915@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Nov 2002 13:37:07 +0100
Message-Id: <1038227827.1272.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-25 at 13:15, Dave Jones wrote:
> On Sat, Nov 23, 2002 at 08:57:20PM +0100, Pavel Machek wrote:
>  
>  > ACPI is marked experimental (and it *is* experimental), if you run it
>  > on production machine you loose.
> 
> Nice. Shame about all those boxes that won't boot without ACPI.

Fortunately there are very very few of those, with the exception of some
laptops with defective IRQ routing tables where the ACPI table happens
to be correct. 
