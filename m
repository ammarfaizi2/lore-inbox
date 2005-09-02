Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVIBQl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVIBQl6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 12:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVIBQl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 12:41:58 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:30172 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750715AbVIBQl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 12:41:58 -0400
Subject: Re: IDE HPA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Molle Bestefich <molle.bestefich@gmail.com>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>, ataraid-list@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <62b0912f05090209242ad72321@mail.gmail.com>
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <200508300859.19701.tennert@science-computing.de>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
	 <1125419927.8276.32.camel@localhost.localdomain>
	 <87941b4c050830095111bf484e@mail.gmail.com>
	 <62b0912f0509020027212e6c42@mail.gmail.com>
	 <1125666332.30867.10.camel@localhost.localdomain>
	 <62b0912f05090206331d04afd3@mail.gmail.com>
	 <E1EBCdS-00064p-00@chiark.greenend.org.uk>
	 <62b0912f05090209242ad72321@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Sep 2005 18:05:12 +0100
Message-Id: <1125680712.30867.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-09-02 at 18:24 +0200, Molle Bestefich wrote:
> I meant the BIOS setup screen, not a firmware update...
> Supposedly the BIOS can change the bounds of the HPA with special ATA commands..

I've yet to see a BIOS that exposed the functionality

> Not if, as proposed, there was a kernel switch to enable including the
> HPA in the disc area.

And users magically knew about it - thats why it has to default the
other way.

