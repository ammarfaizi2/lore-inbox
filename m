Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266525AbUG0UEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266525AbUG0UEZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUG0UEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:04:25 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:8370 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266525AbUG0UES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:04:18 -0400
Date: Tue, 27 Jul 2004 15:03:56 -0500
From: Robin Holt <holt@sgi.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Robin Holt <holt@sgi.com>, Keith Owens <kaos@ocs.com.au>,
       Marcin Owsiany <marcin@owsiany.pl>, linux-kernel@vger.kernel.org
Subject: Re: "swap_free: Unused swap offset entry 00000100" but no crash?
Message-ID: <20040727200356.GA5349@lnx-holt.americas.sgi.com>
References: <20040727002154.GA21628@melina.ds14.agh.edu.pl> <3808.1090931402@ocs3.ocs.com.au> <20040727125304.GA1411@lnx-holt.americas.sgi.com> <20040727185859.GB19107@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727185859.GB19107@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 03:58:59PM -0300, Marcelo Tosatti wrote:
> On Tue, Jul 27, 2004 at 07:53:04AM -0500, Robin Holt wrote:
> > 
> > I remember a race condition I thought was possible, but couldn't exactly
> > pin down the exact sequence.  Give me a chance to dig through some of
> > my notes and see what I come across.
> 
> Would love to hear more details about this.

I can't find anything about this.  I thought it had something to do with
the a race condition around the swap code, but can't recall much more.

Sorry,
Robin
