Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbSLITFL>; Mon, 9 Dec 2002 14:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266042AbSLITFL>; Mon, 9 Dec 2002 14:05:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15115 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266041AbSLITFL>;
	Mon, 9 Dec 2002 14:05:11 -0500
Date: Mon, 9 Dec 2002 19:12:52 +0000
From: Matthew Wilcox <willy@debian.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Matthew Wilcox <willy@debian.org>, Arjan van de Ven <arjanv@redhat.com>,
       =?iso-8859-1?Q?Hanno_B=F6ck?= <hanno@gmx.de>,
       "Grover, Andrew" <andrew.grover@intel.com>, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, acpi-devel@sourceforge.net
Subject: Re: [ACPI] RE: [BK PATCH] ACPI updates
Message-ID: <20021209191252.N20336@parcelfarce.linux.theplanet.co.uk>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A576@orsmsx119.jf.intel.com> <20021206125943.2199892e.hanno@gmx.de> <20021206072932.B16173@devserv.devel.redhat.com> <20021206131746.C10368@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.50L.0212091408120.10894-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.50L.0212091408120.10894-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Dec 09, 2002 at 02:09:04PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 02:09:04PM -0200, Marcelo Tosatti wrote:
> Which machines do not work without the new ACPI code?

hp's zx1-based ia64 machines (my personal interest..) and i thought some
laptops required updated ACPI to boot.  also, aren't there some SMP x86
boxes with buggy bios tables that won't boot without ACPI?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
