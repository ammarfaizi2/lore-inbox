Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbSLITKE>; Mon, 9 Dec 2002 14:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbSLITKE>; Mon, 9 Dec 2002 14:10:04 -0500
Received: from havoc.daloft.com ([64.213.145.173]:215 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S266064AbSLITKD>;
	Mon, 9 Dec 2002 14:10:03 -0500
Date: Mon, 9 Dec 2002 14:17:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Arjan van de Ven <arjanv@redhat.com>, Hanno B?ck <hanno@gmx.de>,
       "Grover, Andrew" <andrew.grover@intel.com>, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, acpi-devel@sourceforge.net
Subject: Re: [ACPI] RE: [BK PATCH] ACPI updates
Message-ID: <20021209191741.GA26391@gtf.org>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A576@orsmsx119.jf.intel.com> <20021206125943.2199892e.hanno@gmx.de> <20021206072932.B16173@devserv.devel.redhat.com> <20021206131746.C10368@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.50L.0212091408120.10894-100000@freak.distro.conectiva> <20021209191252.N20336@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021209191252.N20336@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 07:12:52PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 09, 2002 at 02:09:04PM -0200, Marcelo Tosatti wrote:
> > Which machines do not work without the new ACPI code?
> 
> hp's zx1-based ia64 machines (my personal interest..) and i thought some
> laptops required updated ACPI to boot.  also, aren't there some SMP x86
> boxes with buggy bios tables that won't boot without ACPI?

There are several classes of machines that require ACPI to boot... a big
question is whether these machines need full ACPI or just acpitable.c,
too...

