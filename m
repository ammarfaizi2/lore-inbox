Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWASRht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWASRht (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 12:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWASRht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 12:37:49 -0500
Received: from baikonur.stro.at ([213.239.196.228]:23461 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S1751363AbWASRhs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 12:37:48 -0500
Date: Thu, 19 Jan 2006 18:37:28 +0100
From: maximilian attems <maks@sternwelten.at>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>, Bastian Blank <waldi@debian.org>
Subject: Re: [patch] kbuild: add automatic updateconfig target
Message-ID: <20060119173728.GA4866@nancy>
References: <20060118194056.GA26532@nancy> <Pine.LNX.4.61.0601191248070.11765@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601191248070.11765@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006, Roman Zippel wrote:

> On Wed, 18 Jan 2006, maximilian attems wrote:
> 
> > From: Bastian Blank <waldi@debian.org>
> > 
> > current hack for daily build linux-2.6-git is quite ugly: 
> > yes "n" | make oldconfig
> 
> What's wrong with 'yes "" | make oldconfig'?
> If we added such a make target, it would be basically just this.
> 
> bye, Roman

why should we add this workaround, when adding a target
that sets the default is so easy?

-- 
maks
