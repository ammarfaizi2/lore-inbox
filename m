Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317586AbSHHOmF>; Thu, 8 Aug 2002 10:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317587AbSHHOmF>; Thu, 8 Aug 2002 10:42:05 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:43792 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S317586AbSHHOmF>; Thu, 8 Aug 2002 10:42:05 -0400
Date: Wed, 7 Aug 2002 20:43:32 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Anton Blanchard <anton@samba.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, riel@surriel.com
Subject: Re: fix CONFIG_HIGHPTE
Message-ID: <20020807204332.B5777@nightmaster.csn.tu-chemnitz.de>
References: <20020806231522.GJ6256@holomorphy.com> <3D506D43.890EA215@zip.com.au> <20020807010752.GC6343@krispykreme> <3D508C83.3A78CC58@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3D508C83.3A78CC58@zip.com.au>; from akpm@zip.com.au on Tue, Aug 06, 2002 at 07:57:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 06, 2002 at 07:57:07PM -0700, Andrew Morton wrote:
> - We'll continue to suck for the University workload.

Hop that's not an 2.6 option, because our University alone is
using Linux on 1000+ machines, on 500+ private machines and lots
of mission critical servers.

If Linux becomes crap for the CPU-Server-Load, we would be VERY
sorry here, since we are pushing it very hard[1].

Regards

Ingo Oeser

[1] All interpretions of this sentence apply.
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
