Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266600AbSKGWHx>; Thu, 7 Nov 2002 17:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266602AbSKGWHx>; Thu, 7 Nov 2002 17:07:53 -0500
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:9434 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S266600AbSKGWHu>; Thu, 7 Nov 2002 17:07:50 -0500
Date: Thu, 7 Nov 2002 23:13:35 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: get_user_pages rewrite (completed, updated for 2.4.46)
Message-ID: <20021107231335.Q659@nightmaster.csn.tu-chemnitz.de>
References: <20021107110840.P659@nightmaster.csn.tu-chemnitz.de> <20021107113842.GB23425@holomorphy.com> <20021107135747.A594@rotuma.informatik.tu-chemnitz.de> <20021107125955.GK19821@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20021107125955.GK19821@holomorphy.com>; from wli@holomorphy.com on Thu, Nov 07, 2002 at 04:59:55AM -0800
X-Spam-Score: -3.3 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *189uuz-0000sY-00*d0bSuQeSt2Q*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

On Thu, Nov 07, 2002 at 04:59:55AM -0800, William Lee Irwin III wrote:
> I think just fixing the callers and killing the dead code is all
> that's needed (or wanted).

Ok, so I put it up as splitup patches and as one complete patch onto

   <http://www.tu-chemnitz.de/~ioe/patches-page_walk/index.html>
   
Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
