Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTH1RI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 13:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbTH1RI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 13:08:57 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:36085 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S263590AbTH1RIz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 13:08:55 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: KDB in the mainstream 2.4.x kernels?
Date: Thu, 28 Aug 2003 10:08:50 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE662@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: KDB in the mainstream 2.4.x kernels?
Thread-Index: AcNso4GNVnlA1tqdR9m/on6MzwMzdQA4zthQ
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Andi Kleen" <ak@muc.de>
Cc: "Greg Stark" <gsstark@mit.edu>, "Martin Pool" <mbp@sourcefrog.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Aug 2003 17:08:50.0676 (UTC) FILETIME=[0D3F2340:01C36D87]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Llu, 2003-08-25 at 17:23, Andi Kleen wrote:
> > > instructions as a forth program that frobbed registers 
> appropriately. The
> > > kernel would have a small forth interpretor to run it. 
> Then switching
> > > resolutions could happen safely in the kernel.
> > 
> > Did the proposal come with working code?
> 
> I've seen workable non forth versions of the proposal yes. It isnt 
> actually that hard to do for most video cards 

Interesting.  So did the interpreted forth (or other) program then interact with the VGA BIOS or was it more generic? 

matt
