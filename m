Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279838AbRKMXfw>; Tue, 13 Nov 2001 18:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279824AbRKMXfm>; Tue, 13 Nov 2001 18:35:42 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:21499 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S279832AbRKMXfa>; Tue, 13 Nov 2001 18:35:30 -0500
Date: Tue, 13 Nov 2001 15:29:27 -0800
From: Chris Wright <chris@marcelothewonderpenguin.com>
To: Chris Chabot <chabotc@reviewboard.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile failed on setup.c w/ linux 2.4.15-pre4 for diskless kiosk
Message-ID: <20011113152927.B30898@figure1.int.wirex.com>
Mail-Followup-To: Chris Chabot <chabotc@reviewboard.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1005691331.4877.0.camel@gandbook.chabotc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1005691331.4877.0.camel@gandbook.chabotc.com>; from chabotc@reviewboard.com on Tue, Nov 13, 2001 at 11:42:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Chabot (chabotc@reviewboard.com) wrote:
> while trying to compile linux-2.4.15-pre4 for a diskless kiosk client,
> the compile (bzImage) failed on compiling 
> setup.c:2791 "Subscribed value is neither array or pointer"
> setup.c:2792 "warning: control reaches end of non-void function"
> (arch/i386/kernel/setup.c)

this is in the archives.  the patch is here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=100559812101821&w=2

cheers,
-chris
