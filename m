Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSLUPMw>; Sat, 21 Dec 2002 10:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSLUPMv>; Sat, 21 Dec 2002 10:12:51 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:46098 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S261330AbSLUPMu>; Sat, 21 Dec 2002 10:12:50 -0500
Date: Sat, 21 Dec 2002 08:19:13 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: "David S. Miller" <davem@redhat.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <4085892704.1040483953@aslan.scsiguy.com>
In-Reply-To: <1040443851.1441.0.camel@rth.ninka.net>
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com>
 	<176730000.1040430221@aslan.btc.adaptec.com>
 	<20021221002940.GM25000@holomorphy.com>
 	<190380000.1040432350@aslan.btc.adaptec.com>
 	<20021221013500.GN25000@holomorphy.com>
 	<223910000.1040435985@aslan.btc.adaptec.com>
 <1040443851.1441.0.camel@rth.ninka.net>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2002-12-20 at 17:59, Justin T. Gibbs wrote:
>> Those were committed in separate changes into our local Perforce
>> repository, but I simply don't have the patience to replicate each
>> individual change in Perforce into a BK change.  Since all of the
>> Linux universe likes stuff in BK format, I do what I can to accomodate
>> them.
> 
> Justin, no offense, but if you're not going to use the tool properly,
> just stick with patches.

David,

I'm glad you performed a thorough analysis of how I use BK prior
to commenting.  I think that if you look here, I put more information
into BK than most people.  Considering that it was only recently that
the Linux community decided that revision control was a good thing
and revision information was routinely "lost" on the push to Marcelo
or Linus, I don't see why everyone is being so critical:

http://linux-scsi.bkbits.net:8080/scsi-aic7xxx-2.5/cset@1.865.2.6?nav=index
.html|ChangeSet@-1d

And yes, this changeset was created *before* this thread even started.

--
Justin

