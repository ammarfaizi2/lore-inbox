Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVG1OXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVG1OXc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVG1OVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:21:47 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:6566 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261495AbVG1OUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:20:02 -0400
Date: Thu, 28 Jul 2005 08:19:52 -0600 (MDT)
From: "Ronald G. Minnich" <rminnich@lanl.gov>
To: Christoph Hellwig <hch@infradead.org>
cc: ericvh@gmail.com, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [V9fs-developer] Re: [PATCH 2.6.13-rc3-mm2] v9fs: add fd based
 transport
In-Reply-To: <20050728141749.GB22173@infradead.org>
Message-ID: <Pine.LNX.4.58.0507280819210.12285@enigma.lanl.gov>
References: <200507281358.j6SDwBRZ026263@ms-smtp-03-eri0.texas.rr.com>
 <20050728141749.GB22173@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Jul 2005, Christoph Hellwig wrote:

> Couldn't the two other transports be implemented ontop of this one using
> a mount helper doing the pipe or tcp setup?

that's how we did it in the version we did for 2.4. I don't see why not.

ron
