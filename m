Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267754AbUHEO14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267754AbUHEO14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 10:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267753AbUHEO1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 10:27:52 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:38665 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267748AbUHEOXe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 10:23:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: cciss update [1 of 6]
Date: Thu, 5 Aug 2004 09:23:20 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DBFBA7@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-topic: cciss update [1 of 6]
Thread-index: AcR6emveG6CgavjzQnG/7VVBzl/CfgAfPUqg
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <axboe@suse.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Aug 2004 14:23:22.0322 (UTC) FILETIME=[C32CCB20:01C47AF7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I thought the descriptions in the patch were sufficient. 
Again, I wish viro would copy me on patches to cciss. Isn't that the normal protocol, include the maintainer in any updates?

mikem

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org]
Sent: Wednesday, August 04, 2004 6:29 PM
To: Miller, Mike (OS Dev)
Cc: axboe@suse.de; linux-kernel@vger.kernel.org
Subject: Re: cciss update [1 of 6]


"Miller, Mike (OS Dev)" <mike.miller@hp.com> wrote:
>
> Patch 1 of 6
> Name: p001_ioctl32_fix_for_268rc2.patch

It would make life easier for me if you could give each patch a nice
Subject: which describes what it does.  "cciss update [N of 6]" isn't very
meaningful.  And the name of the file into which you chose to place the
patch isn't a suitable description either.  Thanks.

All of these patches are generating rejects for me - eager beavers have
been patching your driver when you weren't looking.  Could you please redo
and reissue the patch series against -rc3?

Thanks.
