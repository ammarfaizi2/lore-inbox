Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSLFMWK>; Fri, 6 Dec 2002 07:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262416AbSLFMWK>; Fri, 6 Dec 2002 07:22:10 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20674 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262395AbSLFMWK>; Fri, 6 Dec 2002 07:22:10 -0500
Date: Fri, 6 Dec 2002 07:29:32 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: =?iso-8859-1?Q?Hanno_B=F6ck?= <hanno@gmx.de>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, pavel@ucw.cz,
       arjanv@redhat.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, acpi-devel@sourceforge.net
Subject: Re: [ACPI] RE: [BK PATCH] ACPI updates
Message-ID: <20021206072932.B16173@devserv.devel.redhat.com>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A576@orsmsx119.jf.intel.com> <20021206125943.2199892e.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021206125943.2199892e.hanno@gmx.de>; from hanno@gmx.de on Fri, Dec 06, 2002 at 12:59:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 12:59:43PM +0100, Hanno Böck wrote:
> > Well after communicating with Marcelo it sounds like he'd like to hold off
> > taking it in 2.4.21 because IDE changes take priority, and two big changes
> > at once is too many for a stable kernel revision.
> 

> I think this is a very bad news. In my opinion, the ACPI-patch
> is the most-needed kernel-patch at the moment. For many laptop-users
> that don't know about this patch, Linux is nearly
> unuseable. 

the 2.4 patch doesnt' actually offer suspend/resume capabilities; what
else did you have in mind as required ?
