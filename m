Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267371AbSKPVZl>; Sat, 16 Nov 2002 16:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267372AbSKPVZl>; Sat, 16 Nov 2002 16:25:41 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:60823 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S267371AbSKPVZk>; Sat, 16 Nov 2002 16:25:40 -0500
Subject: Re: lan based kgdb
From: Nicholas Miell <nmiell@attbi.com>
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: yodaiken@fsmlabs.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021116172100.GG1877@tahoe.alcove-fr>
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay>
	 <ar3op8$f20$1@penguin.transmeta.com>
	 <20021115222430.GA1877@tahoe.alcove-fr> <3DD57A5F.87119CB4@digeo.com>
	 <20021115225932.GC1877@tahoe.alcove-fr>
	 <20021116092341.A30010@hq.fsmlabs.com>
	 <20021116172100.GG1877@tahoe.alcove-fr>
Content-Type: text/plain
Organization: 
Message-Id: <1037482326.14832.7.camel@entropy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 16 Nov 2002 13:32:29 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-16 at 09:21, Stelian Pop wrote:
> Agreed. But even a suspect debugger is preferable to no debugger at all.
> 
> Look, serial ports are becoming obsolete. We (not everybody but many
> people) need kgdb.
> 

Machines may not ship with serial ports anymore, but theoretically they
should have debug ports.

(A Debug Port being a 16550 with an arbitrary IO port, an ACPI table
entry, and a connector on the motherboard. There's a spec on the
Microsoft web site with the details, but there's a click-through license
agreement and IANAL, so read at your own risk.)
-- 
Nicholas Miell <nmiell@attbi.com>

