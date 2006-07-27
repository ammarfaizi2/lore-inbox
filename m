Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161041AbWG0Ekw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbWG0Ekw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 00:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWG0Ekw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 00:40:52 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:36565 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751283AbWG0Ekv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 00:40:51 -0400
Date: Thu, 27 Jul 2006 00:40:04 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: ricknu-0@student.ltu.se
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       jeff@garzik.org, adobriyan@gmail.com, vlobanov@speakeasy.net,
       jengelh@linux01.gwdg.de, getshorty_@hotmail.com,
       pwil3058@bigpond.net.au, mb@bu3sch.de, penberg@cs.helsinki.fi,
       stefanr@s5r6.in-berlin.de, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 6)
Message-ID: <20060727044004.GJ28284@filer.fsl.cs.sunysb.edu>
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153945705.44c7d069c5e18@portal.student.luth.se> <20060726180622.63be9e55.pj@sgi.com> <20060727021047.GG28284@filer.fsl.cs.sunysb.edu> <1153972270.44c8382ea9da5@portal.student.luth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153972270.44c8382ea9da5@portal.student.luth.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 05:51:10AM +0200, ricknu-0@student.ltu.se wrote:
...
> Hope it make some sense.

Fair enough.

> PS
> If I got you wrong and you meant why it can't be defined where it is used, I
> refere you to Andrew's mail "[patch 1/1] consolidate TRUE and FALSE", where a
> redefinition occured (of TRUE/FALSE).

You first guess was right.

Josef "Jeff" Sipek.

-- 
NT is to UNIX what a doughnut is to a particle accelerator.
