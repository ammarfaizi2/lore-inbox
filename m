Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWEPOvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWEPOvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWEPOvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:51:21 -0400
Received: from xenotime.net ([66.160.160.81]:28595 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750900AbWEPOvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:51:20 -0400
Date: Tue, 16 May 2006 07:53:40 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: George Nychis <gnychis@cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem booting 2.4.32, unknown symbol
Message-Id: <20060516075340.8d387ddb.rdunlap@xenotime.net>
In-Reply-To: <4469E51E.80103@cmu.edu>
References: <4469E51E.80103@cmu.edu>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006 10:43:42 -0400 George Nychis wrote:

> Hi,
> 
> I am trying to boot 2.4.32 with FC3, whenever i try to boot i get the
> following errors:
> 
> insmod: error inserting `/lib/scsi_mod.o': -1 Unknown symbol in module
> ERROR /bin/insmod excited abnormally!
> insmod: error inserting `/lib/sd_mod.o': -1 Unknown symbol in module
> 
> I get the same error for libata.o, ata_piix.o, and lvm-mod.o
> 
> then i get failed to create /edv/ide/host0/bus0/target0/lun0/disc
> 
> So my guess is trying to fix the top most first
> 
> Anyone have any ideas?

I don't know the problem, but dmesg should show you/us the
actual symbol that is wanted and missing, so please provide that.

---
~Randy
