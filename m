Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTJaVwc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 16:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTJaVwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 16:52:32 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:46857 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S263638AbTJaVwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 16:52:31 -0500
From: Chris Vine <chris@cvine.freeserve.co.uk>
To: Rik van Riel <riel@redhat.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Date: Fri, 31 Oct 2003 21:52:17 +0000
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310312152.17834.chris@cvine.freeserve.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 October 2003 3:57 am, Rik van Riel wrote:
> On Wed, 29 Oct 2003, Chris Vine wrote:
> > However, on a low end machine (200MHz Pentium MMX uniprocessor with only
> > 32MB of RAM and 70MB of swap) I get poor performance once extensive use
> > is made of the swap space.
>
> Could you try the patch Con Kolivas posted on the 25th ?
>
> Subject: [PATCH] Autoregulate vm swappiness cleanup

I will do that over the weekend and report back.

Chris.

