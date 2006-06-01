Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWFAJmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWFAJmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWFAJmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:42:18 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:4546 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750745AbWFAJmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:42:17 -0400
Date: Thu, 1 Jun 2006 11:42:14 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Keith Chew <keith.chew@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: IO APIC IRQ assignment
Message-ID: <20060601094214.GA14431@harddisk-recovery.com>
References: <20f65d530605300521q1d56c3a3t84be3d92f1df0c14@mail.gmail.com> <20060530135017.GD5151@harddisk-recovery.com> <20f65d530605300705l60bfcca7k47a41c95bf42a0ef@mail.gmail.com> <Pine.LNX.4.61.0606010002200.30170@yvahk01.tjqt.qr> <20f65d530605311612n15820847sca559d0c443fc230@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20f65d530605311612n15820847sca559d0c443fc230@mail.gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 11:12:43AM +1200, Keith Chew wrote:
> >>
> >Plus
> >CONFIG_X86_UP_APIC=y
> >CONFIG_X86_UP_IOAPIC=y
> >CONFIG_X86_LOCAL_APIC=y
> >CONFIG_X86_IO_APIC=y
> >
> >but I guess you already have these.
> >
> 
> Yes, I have these options enabled.

Could you post a boot log?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
