Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264540AbUFJJhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUFJJhi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 05:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264206AbUFJJfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 05:35:03 -0400
Received: from floyd.utc.fr ([195.83.155.17]:56019 "EHLO floyd.utc.fr")
	by vger.kernel.org with ESMTP id S264531AbUFJIlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 04:41:09 -0400
Message-ID: <1086856855.40c81e9743fba@mailetu.utc.fr>
Date: Thu, 10 Jun 2004 10:40:55 +0200
From: eric.piel@tremplin-utc.net
To: William Lee Irwin III <wli@holomorphy.com>
Cc: high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
References: <40C7BE29.9010600@am.sony.com> <20040610024009.GS1444@holomorphy.com>
In-Reply-To: <20040610024009.GS1444@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Spam-Checked-By: gamma.utc.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting William Lee Irwin III <wli@holomorphy.com>:
> On Wed, Jun 09, 2004 at 06:49:29PM -0700, Geoff Levand wrote:
> > Available at 
> > http://tree.celinuxforum.org/pubwiki/moin.cgi/CELinux_5fPatchArchive
> > For those interested, the set of three patches provide POSIX high-res 
> > timer support for linux-2.6.6.  The core and i386 patches are updates of 
> > George Anzinger's hrtimers-2.6.5-1.0.patch available on SourceForge 
> > <http://sourceforge.net/projects/high-res-timers/>.  The ppc32 port is 
> > not available on SourceForge yet.
> > -Geoff
> 
> I thought George Anzinger's high resolution timer patches had already
> been merged? At the very least there's already a kernel/posix-timers.c

Not exactly, what has been merged is only the POSIX interface of the timers. The
patches to obtain a high resolution (in the order of 10 microseconds instead of
1ms) are still out from the vanilla kernel.

Eric

