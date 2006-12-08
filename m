Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424330AbWLHEYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424330AbWLHEYg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 23:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424324AbWLHEYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 23:24:36 -0500
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:55442 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424315AbWLHEYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 23:24:35 -0500
Date: Thu, 7 Dec 2006 23:24:26 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Kyle McMartin <kyle@parisc-linux.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: [2.6 patch] arch/parisc/Makefile: remove GCC_VERSION
Message-ID: <20061208042425.GC2606@athena.road.mcmartin.ca>
References: <20061201114908.GR11084@stusta.de> <20061201182355.GC10549@colo.lackof.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201182355.GC10549@colo.lackof.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 11:23:55AM -0700, Grant Grundler wrote:
> I've committed a variant of this to git://git.parisc-linux.org/git/linux-2.6.git
> I didn't test the failure case - only that it doesn't trigger with
> my current gcc 4.x compilers.
> 
> I expect Kyle will push parisc tree to linus in the near future.
> 
> Signed-off-by: Grant Grundler <grundler@parisc-linux.org>
> 

I like the version ggg committed to our cvs better (and I verified it
correctly functions with gcc-3.0 from Debian woody.)

Picked into my tree.

Cheers,
	Kyle
