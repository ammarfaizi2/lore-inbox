Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSEKEka>; Sat, 11 May 2002 00:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314557AbSEKEk3>; Sat, 11 May 2002 00:40:29 -0400
Received: from holomorphy.com ([66.224.33.161]:57742 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314529AbSEKEk2>;
	Sat, 11 May 2002 00:40:28 -0400
Date: Fri, 10 May 2002 21:39:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 : drivers/block/paride/pcd.c minor unused var patch
Message-ID: <20020511043908.GC32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0205110017490.4085-100000@localhost.localdomain> <20020511043630.GB32767@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, May 11, 2002 at 12:22:01AM -0400, Frank Davis wrote:
> > Hello all,
> >   The following just removes an unused varible (Didn't see this posted 
> > yet). 
> > 

On Fri, May 10, 2002 at 09:36:30PM -0700, William Lee Irwin III wrote:
> both unit and i are unused and there's a bit of style breakage to fix.

woops, missed ^W's, unit is used later.

Cheers,
Bill
