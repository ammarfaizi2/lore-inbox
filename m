Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266125AbTLIVEp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 16:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266130AbTLIVEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 16:04:45 -0500
Received: from cmailm6.svr.pol.co.uk ([195.92.193.22]:33721 "EHLO
	cmailm6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S266125AbTLIVEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 16:04:44 -0500
From: Chris Vine <chris@cvine.freeserve.co.uk>
To: Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Date: Tue, 9 Dec 2003 21:03:04 +0000
User-Agent: KMail/1.5.4
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <20031208135225.GT19856@holomorphy.com> <200312090123.31895.kernel@kolivas.org>
In-Reply-To: <200312090123.31895.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312092103.04328.chris@cvine.freeserve.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 December 2003 2:23 pm, Con Kolivas wrote:
> [snip original discussion thrashing swap on 2.6test with 32mb ram]
>
> Chris
>
> By an unusual coincidence I was looking into the patches that were supposed
> to speed up application startup and noticed this one was merged. A brief
> discussion with wli suggests this could cause thrashing problems on low
> memory boxes so can you try this patch? Applies to test11.
>
> Con

Con,

I have just got back from a trip away.  I will try out the patch tomorrow, I 
hope, and see what difference it makes.

Chris.

