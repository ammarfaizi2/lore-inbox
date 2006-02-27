Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWB0OuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWB0OuN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 09:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWB0OuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 09:50:13 -0500
Received: from usmimesweeper.bluearc.com ([63.203.197.133]:21266 "EHLO
	us-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S1751371AbWB0OuL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 09:50:11 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Date: Mon, 27 Feb 2006 14:50:08 -0000
Message-ID: <89E85E0168AD994693B574C80EDB9C270393BF13@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Thread-Index: AcY7q7ArVIRaZ7T+STqF6vi6zb9C2gAAUYZw
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Anton Altaparmakov" <aia21@cam.ac.uk>, "Andrew Morton" <akpm@osdl.org>,
       <davej@redhat.com>, <linux-kernel@vger.kernel.org>,
       <lwoodman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens

> On Mon, Feb 27 2006, Andy Chittenden wrote:
> > Jens,
> > 
> > It looks like my message containing the updated dmesg 
> output didn't make
> > it out (well it's not in the lkml archives anyway (that I 
> could see!)).
> > Anyway, here's the output from dmesg one more time. Hope it 
> helps you
> > diagnose/fix this problem:
> 
> Any chance you can try the patch Andi posted to fix the 
> bounce setup on
> 64-bti machines? Should fix your case, I think. Let me know if you
> missed it, and I'll dig out the link again.

I missed it - please can you dig it out and I'll give it a go.

-- 
Andy, BlueArc Engineering
