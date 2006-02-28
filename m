Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWB1K1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWB1K1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWB1K1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:27:30 -0500
Received: from usmimesweeper.bluearc.com ([63.203.197.133]:20228 "EHLO
	us-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S932128AbWB1K13 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:27:29 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Date: Tue, 28 Feb 2006 10:27:26 -0000
Message-ID: <89E85E0168AD994693B574C80EDB9C270393BFBF@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Thread-Index: AcY8UJpnkTXpa1APT8uzpk0MvBZO/wAALJmg
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Anton Altaparmakov" <aia21@cam.ac.uk>, "Andrew Morton" <akpm@osdl.org>,
       <davej@redhat.com>, <linux-kernel@vger.kernel.org>,
       <lwoodman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do the messages go
> away if you do:
> 
> > Looks like a VIA chipset. Disabling IOMMU. Overwrite with
> > "iommu=allowed"
> 
> like that suggests?

it hangs during boot :-( at:

hda: cache flushes supported
 hda:

-- 
Andy, BlueArc Engineering
