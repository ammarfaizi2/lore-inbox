Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbTIEAsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 20:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTIEAsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 20:48:41 -0400
Received: from SPARCLINUX.MIT.EDU ([18.248.2.241]:46597 "EHLO
	sparclinux.mit.edu") by vger.kernel.org with ESMTP id S261714AbTIEAsj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 20:48:39 -0400
Date: Thu, 4 Sep 2003 20:48:37 -0400
From: Rob Radez <rob@osinvestor.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Justin Cormack <justin@street-vision.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0-test4 - Watchdog patches
Message-ID: <20030905004837.GA19677@osinvestor.com>
References: <20030831225236.A6938@infomag.infomag.iguana.be> <1062364509.30543.155.camel@lotte.street-vision.com> <20030903215410.F8811@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903215410.F8811@infomag.infomag.iguana.be>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 09:54:10PM +0200, Wim Van Sebroeck wrote:
> Hi Justin,
> 
> > There is *no point* making these module parameters. There is no other
> > watchdog that works in exactly the same way but using different io
> > ports. If there was this still wouldnt be the sensible way to do it. 
> 
> Since I copied this part of Rob's watchdog-patch, I'll let Rob answer this one.

Mostly, it was because I didn't know that there weren't any other
implementations of this watchdog that might use slightly different
ports.  If there aren't, then my apologies for unnecessary complication
of the code.

Regards,
Rob Radez
