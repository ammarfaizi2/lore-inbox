Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313680AbSDUSIa>; Sun, 21 Apr 2002 14:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313712AbSDUSI3>; Sun, 21 Apr 2002 14:08:29 -0400
Received: from bitmover.com ([192.132.92.2]:33435 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313707AbSDUSI1>;
	Sun, 21 Apr 2002 14:08:27 -0400
Date: Sun, 21 Apr 2002 11:08:26 -0700
From: Larry McVoy <lm@bitmover.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Jeff Garzik <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020421110826.N10525@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Jeff Garzik <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020421101731.D10525@work.bitmover.com> <20020421132203.E4479@havoc.gtf.org> <E16yyya-0000l7-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 07:48:44PM +0200, Daniel Phillips wrote:
> Plus, the url saves download
> bandwidth.  A compelling argument I'd say.

The docs are all of 12K, I just went and looked.  If you care about
bandwidth, you'd be arguing in favor of BK, it saves tons of bandwidth
compared to diff and patch.

In fact, your path to remove them proves that.  If you cared about bandwidth,
you would have posted a BK patch to do it.  :-)
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
