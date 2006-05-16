Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWEPPMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWEPPMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWEPPMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:12:23 -0400
Received: from xenotime.net ([66.160.160.81]:39621 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932073AbWEPPMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:12:22 -0400
Date: Tue, 16 May 2006 08:14:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: George Nychis <gnychis@cmu.edu>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: problem booting 2.4.32, unknown symbol
Message-Id: <20060516081442.579d3c12.rdunlap@xenotime.net>
In-Reply-To: <4469E839.3090806@cmu.edu>
References: <4469E51E.80103@cmu.edu>
	<20060516075340.8d387ddb.rdunlap@xenotime.net>
	<4469E839.3090806@cmu.edu>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006 10:56:57 -0400 George Nychis wrote:

> 
> 
> Randy.Dunlap wrote:
> > On Tue, 16 May 2006 10:43:42 -0400 George Nychis wrote:
> > 
> >> Hi,
> >>
> >> I am trying to boot 2.4.32 with FC3, whenever i try to boot i get the
> >> following errors:
> >>
> >> insmod: error inserting `/lib/scsi_mod.o': -1 Unknown symbol in module
> >> ERROR /bin/insmod excited abnormally!
> >> insmod: error inserting `/lib/sd_mod.o': -1 Unknown symbol in module
> >>
> >> I get the same error for libata.o, ata_piix.o, and lvm-mod.o
> >>
> >> then i get failed to create /edv/ide/host0/bus0/target0/lun0/disc
> >>
> >> So my guess is trying to fix the top most first
> >>
> >> Anyone have any ideas?
> > 
> > I don't know the problem, but dmesg should show you/us the
> > actual symbol that is wanted and missing, so please provide that.
> > 
> > ---
> > ~Randy
> > 
> 
> If the system doesn't boot, how can i get the dmesg?

aha, my bad, sorry.
I'll have to defer to someone who knows about FC3.

---
~Randy
