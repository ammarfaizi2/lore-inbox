Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267699AbUBRUdl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268061AbUBRUdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:33:41 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:37572 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267699AbUBRUdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:33:37 -0500
Date: Wed, 18 Feb 2004 15:33:03 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Alexander Hoogerhuis <alexh@ihatent.com>, Zoltan NAGY <nagyz@nefty.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: v2.6 in vmware?
In-Reply-To: <20040218200607.GA12982@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.58.0402181532210.7734@montezuma.fsmlabs.com>
References: <10ADD433537@vcnet.vc.cvut.cz> <8765e4fayx.fsf@lapper.ihatent.com>
 <20040218200607.GA12982@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004, Petr Vandrovec wrote:

> On Wed, Feb 18, 2004 at 08:23:34PM +0100, Alexander Hoogerhuis wrote:
> > "Petr Vandrovec" <VANDROVE@vc.cvut.cz> writes:
> >
> > > On 18 Feb 04 at 14:37, Zoltan NAGY wrote:
> > > > I've been trying to get 2.6.x working in vmware4, but it drops some
> > > > oopses during init... I cannot provide details, but I'm sure that it
> > > > does not just me who are having problems with it..
> > >
> > > Definitely you are... I do not know about any problems with running
> > > 2.6.x as a guest under VMware.
> > >
> >
> > There was something about sysenter support or something in that
> > general direction; I had Zwane Mwaikambo send me a patch that worked
> > around this for pre 4.0.5 vmware, but never got around to test it as I
> > upgraded the vmware software.
>
> I have all reasons to believe that this is fixed in 4.0.5. It is definitely
> fixed in 4.5.

Yes that sysenter patch is not required to run Linux 2.6 as a guest in
VMWare 4.05 (verified on build 6030)

