Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbTA2N2j>; Wed, 29 Jan 2003 08:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266038AbTA2N2j>; Wed, 29 Jan 2003 08:28:39 -0500
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:18590 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S265987AbTA2N2i>; Wed, 29 Jan 2003 08:28:38 -0500
Date: Tue, 28 Jan 2003 20:24:26 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Raphael Schmid <Raphael_Schmid@CUBUS.COM>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
Message-ID: <20030128202426.E646@nightmaster.csn.tu-chemnitz.de>
References: <398E93A81CC5D311901600A0C9F2928946936D@cubuss2> <1529810000.1043776134@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1529810000.1043776134@titus>; from mbligh@aracnet.com on Tue, Jan 28, 2003 at 09:48:55AM -0800
X-Spam-Score: -3.1 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18dsPe-0004aV-00*s0Mab7MyL6o*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Tue, Jan 28, 2003 at 09:48:55AM -0800, Martin J. Bligh wrote:
[Linux and Bootscreens]

> I think it's a better plan to justify new features with an explantion
> of why we should have something, rather than than saying there's no
> reason we shouldn't. 

Ok, I would say there are several reasons:

   - People like themes and this makes the theme madness more
     complete

   - Some people get nervous, if they see text (esp. slow
     readers for obvious reasons)

   - Other people consider graphics archaic and "uncool"

The last 2 apply to kids as well.

So there are usability concerns and the boot might be the right
place to implement that kind bootscreen retainment.

Showing the dmesg log buffer on panic or BUG would be a nice
thing, to retain usability in that case as well.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
