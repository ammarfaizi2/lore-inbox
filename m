Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319042AbSH2ALz>; Wed, 28 Aug 2002 20:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319047AbSH2ALz>; Wed, 28 Aug 2002 20:11:55 -0400
Received: from dp.samba.org ([66.70.73.150]:31971 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319042AbSH2ALy>;
	Wed, 28 Aug 2002 20:11:54 -0400
Date: Thu, 29 Aug 2002 10:02:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Compile fix for magic sysrq and !CONFIG_VT
Message-ID: <20020829000237.GD7330@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org
References: <20020827020855.GW18818@zax> <Pine.LNX.4.33.0208281153290.1459-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0208281153290.1459-100000@maxwell.earthlink.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 11:58:07AM -0700, James Simmons wrote:
> 
> > Linus, please apply.  This fixes compilation of the magic sysrq code
> > when compiled without CONFIG_VT.
> 
> Ug. I have had this fix for awhile in the console BK tree. That and
> several other ones. I'm merging my tree with 2.5.32 right now and I will
> push it to linus as soon as I'm done tetsing.

Ok, great.  Sorry I didn't get in touch with you first, but it wasn't
obvious who the right person was.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
