Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131261AbRCNSqj>; Wed, 14 Mar 2001 13:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131387AbRCNSq3>; Wed, 14 Mar 2001 13:46:29 -0500
Received: from h55t105.delphi.afb.lu.se ([130.235.188.122]:61458 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id <S131261AbRCNSqY>;
	Wed, 14 Mar 2001 13:46:24 -0500
Date: Wed, 14 Mar 2001 19:45:28 +0100 (CET)
From: Peter Svensson <petersv@psv.nu>
To: Christoph Hellwig <hch@caldera.de>
cc: John Jasen <jjasen1@umbc.edu>, <linux-kernel@vger.kernel.org>,
        AmNet Computers <amnet@amnet-comp.com>
Subject: Re: magic device renumbering was -- Re: Linux 2.4.2ac20
In-Reply-To: <200103141823.TAA11310@ns.caldera.de>
Message-ID: <Pine.LNX.4.30.0103141929420.11312-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2001, Christoph Hellwig wrote:

> Put LABEL=<label set with e2label> in you fstab in place of the device name.
>
> 	Christoph
>
> P.S. UUID= work, too - but I prefer a human-readable label...

There are a lot of different devices besides disks, e.g. tape drives etc.
I seem to remember from the last round this came up that modern FC fabrics
have some dynamic properties that may require more intelligence in the
kernel.

Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
<petersv@df.lth.se> !
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...


