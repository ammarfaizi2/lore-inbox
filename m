Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751166AbWFEOpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWFEOpj (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 10:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWFEOpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 10:45:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18600 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751166AbWFEOpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 10:45:38 -0400
Subject: Re: 2.6.18 -mm merge plans -- GFS
From: Steven Whitehouse <swhiteho@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
        Patrick Caulfield <pcaulfie@redhat.com>, davej@redhat.com,
        David Teigland <teigland@redhat.com>
In-Reply-To: <1149514730.30024.133.camel@pmac.infradead.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <1149514730.30024.133.camel@pmac.infradead.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 05 Jun 2006 16:01:31 +0100
Message-Id: <1149519691.3856.1002.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-06-05 at 14:38 +0100, David Woodhouse wrote:
> On Sun, 2006-06-04 at 13:50 -0700, Andrew Morton wrote:
> > It's time to take a look at the -mm queue for 2.6.18.
> 
> You didn't mention GFS2 either -- is that ready to go upstream?

Assuming that 2.6.18 is imminent, as I understand it is, then my
preferred option would be for GFS2 to spend one more cycle in -mm,
assuming that nobody would disagree with that. I pretty sure that we'll
be ready by the time 2.6.19 comes around to request inclusion upstream
but 2.6.18 might be just a bit too soon,

Steve.


