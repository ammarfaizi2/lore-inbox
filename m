Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVDAAwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVDAAwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 19:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVDAAwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 19:52:43 -0500
Received: from ozlabs.org ([203.10.76.45]:17620 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262062AbVDAAwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 19:52:41 -0500
Date: Fri, 1 Apr 2005 09:49:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linuxppc64-dev@ozlabs.org,
       anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc1-mm5 1/3] perfctr: ppc64 arch hooks
Message-ID: <20050331234940.GA21676@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Mikael Pettersson <mikpe@csd.uu.se>,
	linuxppc64-dev@ozlabs.org, anton@samba.org,
	linux-kernel@vger.kernel.org
References: <200503312207.j2VM7YUI011924@alkaid.it.uu.se> <20050331151129.279b0618.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331151129.279b0618.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 03:11:29PM -0800, Andrew Morton wrote:
> Mikael Pettersson <mikpe@csd.uu.se> wrote:
> >
> > Here's a 3-part patch kit which adds a ppc64 driver to perfctr,
> > written by David Gibson <david@gibson.dropbear.id.au>.
> 
> Well that seems like progress.  Where do we feel that we stand wrt
> preparedness for merging all this up?

I'm still uneasy about it.  There were sufficient changes made getting
this one ready to go that I'm not confident there aren't more
important things to be found.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
