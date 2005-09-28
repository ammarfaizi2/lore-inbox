Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbVI1QgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbVI1QgQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbVI1QgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:36:15 -0400
Received: from magic.adaptec.com ([216.52.22.17]:56513 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751407AbVI1QgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:36:14 -0400
Message-ID: <433AC66E.3050502@adaptec.com>
Date: Wed, 28 Sep 2005 12:35:58 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: ltuikov@yahoo.com, Andre Hedrick <andre@linux-ide.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <20050928113703.65626.qmail@web31806.mail.mud.yahoo.com> <200509281630.j8SGULJi022471@turing-police.cc.vt.edu>
In-Reply-To: <200509281630.j8SGULJi022471@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2005 16:36:07.0351 (UTC) FILETIME=[B9C90470:01C5C44A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/05 12:30, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 28 Sep 2005 04:37:03 PDT, Luben Tuikov said:
> 
> 
>>When it comes down to it SCSI Core is 20 years behind and thus Linux Storage
>>is 20 years behind.
> 
> 
> Hmm.. 20 years ago I was hooking Fujitsu Super-Eagles to Sun3/280 servers.
> If you're going to claim that the current SCSI core is *that* far behind, you're
> going to have to back it up.  Remember that making exaggerated claims is a good
> way to make people not listen to the *rest* of your message.
> 
> Seen in include/scsi/scsi.h:
> 
>         /*
>          * FIXME: bit0 is listed as reserved in SCSI-2, but is
>          * significant in SCSI-3.  For now, we follow the SCSI-2
>          * behaviour and ignore reserved bits.
>          */
> 
> So obviously, it's at least the number of years since SCSI-3 was defined,
> but no more than the time since SCSI-2.  According to http://home.comcast.net/~SCSIguy/SCSI_FAQ/scsifaq.html
> SCSI-2 devices started showing up in 1988, and X3.131-1994 came out in 1994.
> 1996 saw the first SCSI-3 proposals.
> 
> I'll give you *one* decade, but not two. :)

Ok, I'll take that.

BTW, I was referring to the _architecture_ of SCSI Core.

It hasn't seen any _innovation_ for the last 5 years
as far as SCSI or Storage is concerned.

	Luben

