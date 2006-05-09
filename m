Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWEIVAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWEIVAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 17:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWEIVAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 17:00:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32224 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750791AbWEIVAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 17:00:32 -0400
Date: Tue, 9 May 2006 16:58:35 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Richard J Moore <richardj_moore@uk.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>, suparna@in.ibm.com
Subject: Re: [RFC] [PATCH 3/6] Kprobes: New interfaces for user-space probes
Message-ID: <20060509205835.GD13413@redhat.com>
References: <20060509093614.GB26953@infradead.org> <OFB21F3208.CA125B3A-ON41257169.005345DD-41257169.005375F5@uk.ibm.com> <20060509151857.GB16332@infradead.org> <y0mk68vyu2y.fsf@ton.toronto.redhat.com> <20060509204052.GN3570@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509204052.GN3570@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On Tue, May 09, 2006 at 10:40:52PM +0200, Adrian Bunk wrote:
> > It is reasonable to want to see code that exercises this function.
> > Until systemtap does, hand-written examples can surely be provided.
> 
> It's not about examples, it's about in-kernel users.

Just as for kprobes, this facility is for dynamically generated
kernel-resident code.  Just as for kprobes, there is nothing there to
submit to lkml to be "in-kernel" in that sense.

- FChE
