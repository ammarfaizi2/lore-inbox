Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbUJ0VIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbUJ0VIF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbUJ0VHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:07:03 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:2255 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262707AbUJ0U62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:58:28 -0400
Date: Wed, 27 Oct 2004 22:58:03 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Larry McVoy <lm@bitmover.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@novell.com>,
       Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <20041027035412.GA8493@work.bitmover.com>
Message-ID: <Pine.LNX.4.61.0410272214580.877@scrub.home>
References: <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random>
 <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random>
 <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random>
 <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org>
 <Pine.LNX.4.61.0410252350240.17266@scrub.home> <20041026010141.GA15919@work.bitmover.com>
 <Pine.LNX.4.61.0410270338310.877@scrub.home> <20041027035412.GA8493@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 26 Oct 2004, Larry McVoy wrote:

> On the other hand, if there is information that is not interesting to
> a kernel developer but is interesting to someone trying to rip off our
> software, no, we must respectfully decline to offer that.

Allow me to translate that what this means, so everyone clearly knows 
what's going on here:
The complete development history of the Linux kernel is now effectly 
locked into the bk format, you can get a summary of it, but that's it.
The data everyone put into a bk repository is now owned by BM and only if 
you abide to the rules set by BM, do you have the permission to extract 
some of the data again. You can completely forget the idea to one day 
import "your" data into a different SCM system.

bye, Roman
