Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262946AbVCMEdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbVCMEdr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 23:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbVCMEbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 23:31:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17328 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262911AbVCME3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 23:29:18 -0500
Date: Sat, 12 Mar 2005 23:28:00 -0500
From: Dave Jones <davej@redhat.com>
To: Jesse Barnes <jbarnes@sgi.com>, Mike Werner <werner@sgi.com>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
Message-ID: <20050313042800.GG32494@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesse Barnes <jbarnes@sgi.com>, Mike Werner <werner@sgi.com>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <200503111927.04807.werner@sgi.com> <20050312035809.GB8654@redhat.com> <200503121913.05660.jbarnes@sgi.com> <20050313040820.GE32494@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050313040820.GE32494@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 11:08:20PM -0500, Dave Jones wrote:
 > On Sat, Mar 12, 2005 at 07:13:05PM -0800, Jesse Barnes wrote:
 >  > On Friday, March 11, 2005 7:58 pm, Dave Jones wrote:
 >  > >  > sgi-agp.c was sent to Dave about 2 weeks ago. I assumed he was waiting
 >  > >  > for the TIO header files to make it from the ia64 tree into Linus's
 >  > >  > tree.
 >  > >
 >  > > Actually I just got swamped with other stuff, and dropped the ball.
 >  > > I still have the patch in my queue though, so I can push that along.
 >  > >
 >  > > Are those headers in mainline yet ?
 >  > 
 >  > Yeah, I think it's all there now.  Looks like Linus did a pull from ia64 
 >  > recently, so it *should* all build.
 > 
 > Ok, pushed out to bk://linux-djb.bkbits.net/agpgart

Erk, Personality crisis, or an unfortunate typo. s/djb/dj/ obviously.

		Dave
