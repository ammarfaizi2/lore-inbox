Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWDMR3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWDMR3r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 13:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWDMR3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 13:29:47 -0400
Received: from solarneutrino.net ([66.199.224.43]:15108 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1751025AbWDMR3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 13:29:47 -0400
Date: Thu, 13 Apr 2006 13:29:43 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: lockd oopses continue with 2.6.16.1
Message-ID: <20060413172943.GF12686@tau.solarneutrino.net>
References: <20060412172028.GA12637@tau.solarneutrino.net> <1144942392.25298.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1144942392.25298.6.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 11:33:12AM -0400, Trond Myklebust wrote:
> Does the following patch (applies on top of 2.6.17-rc1) help?
> 
> http://client.linux-nfs.org/Linux-2.6.x/2.6.17-rc1/linux-2.6.17-010-fix_nlm_reclaim_races.dif

Thanks, I'll try this out.  It will probably be at least a couple of
weeks before I can report on whether it works.

Cheers,
-ryan
