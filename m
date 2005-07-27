Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVG0RPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVG0RPH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 13:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVG0RPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 13:15:07 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:53733 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261324AbVG0RPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 13:15:05 -0400
Date: Wed, 27 Jul 2005 10:15:03 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>,
       Kumar Gala <galak@freescale.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 00/14] ppc32: Remove board ports that are no longer maintained
Message-ID: <20050727101502.B1114@cox.net>
References: <Pine.LNX.4.61.0507271029480.12237@nylon.am.freescale.net> <1271.1122480803@marajade.sandelman.ottawa.on.ca> <20050727162741.GC28681@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050727162741.GC28681@gate.ebshome.net>; from ebs@ebshome.net on Wed, Jul 27, 2005 at 09:27:41AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 09:27:41AM -0700, Eugene Surovegin wrote:
> On Wed, Jul 27, 2005 at 12:13:23PM -0400, Michael Richardson wrote:
> > Kumar, I thought that we had some volunteers to take care of some of
> > those. I know that I still care about ep405, and I'm willing to maintain
> > the code.
> 
> Well, it has been almost two months since Kumar asked about maintenance 
> for this board. Nothing happened since then.
> 
> Why is it not fixed yet? Please, send a patch which fixes it. This is 
> the _best_ way to keep this board in the tree, not some empty 
> maintenance _promises_.

When we recover our history from the linuxppc-2.4/2.5 trees we can
show exactly how long it's been since anybody touched ep405.

Quick googling shows that it's been almost 2 years since the last
mention of ep405 (exluding removal discussions) on linuxppc-embedded.
Last ep405-related commits are more than 2 years ago.

-Matt
