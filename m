Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268001AbUH1Aqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268001AbUH1Aqh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 20:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267992AbUH1Aqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 20:46:33 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:18331 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S267818AbUH1Aq2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 20:46:28 -0400
Date: Sat, 28 Aug 2004 01:45:07 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linus Torvalds <torvalds@osdl.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Christoph Hellwig <hch@infradead.org>,
       Craig Milo Rogers <rogers@isi.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       webcam@smcc.demon.nl
Subject: Re: Termination of the Philips Webcam Driver (pwc)
In-Reply-To: <412FB418.1030508@pobox.com>
Message-ID: <Pine.LNX.4.61.0408280141190.2441@fogarty.jakma.org>
References: <20040826233244.GA1284@isi.edu>  <20040827004757.A26095@infradead.org>
  <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org>  <20040827094346.B29407@infradead.org>
  <Pine.LNX.4.58.0408271027060.14196@ppc970.osdl.org> <1093628254.15313.14.camel@gonzales>
 <Pine.LNX.4.58.0408271106330.14196@ppc970.osdl.org>
 <Pine.LNX.4.60.0408272225140.9310@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0408271448400.14196@ppc970.osdl.org> <412FB418.1030508@pobox.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004, Jeff Garzik wrote:

> Yup.
>
> In that fact's what a lot of modern RAID firmwares are, an RTOS 
> running on a generic CPU.  Some NIC firmwares too.

Not just modern, old controllers too, eg DAC960 (i960), ExtremeRAID 
(StrongARM), Compaq Smart-2 (AMD 29k), etc. Hard disks too. Do a 
strings on Seagate SCSI disk firmware, the 'BOS' RTOS iirc. Intel 
IXP2x00 network accelerators are Xscale+added bits (there's a port of 
Fedora for them!).

Linux could be one of several OSes running on any given PC.

> 	Jeff

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
One possible reason that things aren't going according to plan
is that there never was a plan in the first place.
