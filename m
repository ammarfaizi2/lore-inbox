Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262881AbSLFOXs>; Fri, 6 Dec 2002 09:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262884AbSLFOXs>; Fri, 6 Dec 2002 09:23:48 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:27054 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262881AbSLFOXr>; Fri, 6 Dec 2002 09:23:47 -0500
Subject: Re: [ACPI] RE: [BK PATCH] ACPI updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Hanno =?ISO-8859-1?Q?B=F6ck?= <hanno@gmx.de>,
       "Grover, Andrew" <andrew.grover@intel.com>, pavel@ucw.cz,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel@sourceforge.net
In-Reply-To: <20021206131746.C10368@parcelfarce.linux.theplanet.co.uk>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A576@orsmsx119.jf.intel.com>
	<20021206125943.2199892e.hanno@gmx.de>
	<20021206072932.B16173@devserv.devel.redhat.com> 
	<20021206131746.C10368@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 15:06:13 +0000
Message-Id: <1039187173.23271.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 13:17, Matthew Wilcox wrote:
> > the 2.4 patch doesnt' actually offer suspend/resume capabilities; what
> > else did you have in mind as required ?
> 
> booting?

New compaqs, existing xmeta, new HP wont boot without the -ac IDE and
the workarounds for ATi or fixes for ALi IDE. (Users should try to avoid
the ati igp stuff for now btw - no X support, no pci routing support,
most kernels wont run on it, no docs)

Alan

