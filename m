Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266532AbUGPPGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266532AbUGPPGJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 11:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUGPPGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 11:06:09 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:5033 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266532AbUGPPGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 11:06:07 -0400
Date: Fri, 16 Jul 2004 08:04:18 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       John Hawkes <hawkes@sgi.com>
Subject: Re: [PATCH] reduce inter-node balancing frequency
Message-ID: <20040716150418.GA5195@taniwha.stupidest.org>
References: <200407151829.20069.jbarnes@engr.sgi.com> <2700000.1089956404@[10.10.2.4]> <40F76D3F.8050309@yahoo.com.au> <200407161045.38983.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407161045.38983.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2004 at 10:45:38AM -0400, Jesse Barnes wrote:

> For sn2 at least, there are quite a few ways we could dice up the
> topology.  We'll have to experiment with things a bit to find some
> good defaults.

The PROM can export topology details so presumably there is enough to
derive something sane on boot surely?


  --cw
