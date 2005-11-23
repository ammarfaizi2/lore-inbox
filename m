Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbVKWFSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbVKWFSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 00:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbVKWFSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 00:18:15 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:41932 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030313AbVKWFSO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 00:18:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s4bB+6SRYpztIC/Fda7audrkDAoeaTu+wuAB29mCpAtiOcOd1a1XiEOERsAsPUyPI//mfPgsZbY3H/pGOQi60rCt8/bYLLfALkQqt/C8s/b1p0gtfoJ+V1uF3RDFVJ4XXqcm/AZInpuYEM4Ug0OhEX1gipeIRV5dDJWFZBiCm4M=
Message-ID: <9e4733910511222118t67ed3f03qcd1a44037605d5dd@mail.gmail.com>
Date: Wed, 23 Nov 2005 00:18:13 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Christmas list for the kernel
Cc: s0348365@sms.ed.ac.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20051122180006.52d0a6bb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <200511221839.24202.s0348365@sms.ed.ac.uk>
	 <9e4733910511221110j47e8ddcs1c9936db1eb5f0b4@mail.gmail.com>
	 <20051122164353.4177c59a.akpm@osdl.org>
	 <9e4733910511221709t546089d1id76357256079d8f9@mail.gmail.com>
	 <20051122180006.52d0a6bb.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/05, Andrew Morton <akpm@osdl.org> wrote:
>
> grep '^[+-]' $(grep -rl '^From:.*Bunk' patches) | wc -l
>   59298
>
> 59k out of 7M lines changed.

Cool, that's a lot less than I would have thought from the amount of
lkml messages.

Can you do a magic incantation and tell us who the top top twenty
contributors are?

--
Jon Smirl
jonsmirl@gmail.com
