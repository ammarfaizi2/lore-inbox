Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316993AbSF0WFl>; Thu, 27 Jun 2002 18:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316994AbSF0WFk>; Thu, 27 Jun 2002 18:05:40 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28333 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S316993AbSF0WFj>;
	Thu, 27 Jun 2002 18:05:39 -0400
Date: Thu, 27 Jun 2002 15:50:55 -0600 (MDT)
From: "Hurwitz Justin W." <hurwitz@lanl.gov>
To: Nivedita Singhvi <niv@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: zero-copy networking & a performance drop
In-Reply-To: <Pine.LNX.4.33.0206271248260.13115-100000@w-nivedita2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0206271545220.17078-100000@alvie-mail.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2002, Nivedita Singhvi wrote:

[ snip ]

> That said, rx has been slower than sends in most of our testing
> too. 

Is this a documented/explained phemomenon? Or are you and I the only 
people experiencing it? Do we have any idea as to its cause (or is it 
inherent architecturally)? 

Cheers,
--Gus


