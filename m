Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbUCADa0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 22:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUCADa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 22:30:26 -0500
Received: from mail-gate.ait.ac.th ([202.183.214.47]:56483 "EHLO
	mail-gate.ait.ac.th") by vger.kernel.org with ESMTP id S262234AbUCADaY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 22:30:24 -0500
Date: Mon, 1 Mar 2004 10:30:17 +0700
From: Alain Fauconnet <alain@ait.ac.th>
To: Enrico Demarin <enricod@videotron.ca>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Jo Christian Buvarp <jcb@svorka.no>,
       "Moore, Eric Dean" <Emoore@lsil.com>, linux-kernel@vger.kernel.org
Subject: Re: Ibm Serveraid Problem with 2.4.25
Message-ID: <20040301033017.GD1270@ait.ac.th>
References: <403DB882.9000401@svorka.no> <1077839333.4823.5.camel@localhost.localdomain> <1077846502.4454.2.camel@localhost.localdomain> <Pine.LNX.4.58L.0402270011140.2029@logos.cnet> <403EEEB9.5030408@svorka.no> <Pine.LNX.4.58L.0402271133220.18055@logos.cnet> <20040301021014.GA1270@ait.ac.th> <1078110630.4446.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078110630.4446.87.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enrico,

Thanks for the update, but...

On Sun, Feb 29, 2004 at 10:10:30PM -0500, Enrico Demarin wrote:
> Alain,
> 
> so far Jo went through all the pre2.4.24 and 25 and the bug appeared
> in 2.4.24pre1. 

Are you meaning that  the  bug  was  already  present  in  the  2.4.24
release? I'm  a bit confused here.

> 
> - Enrico
> 
> 
> On Sun, 2004-02-29 at 21:10, Alain Fauconnet wrote:
> > On Fri, Feb 27, 2004 at 11:36:51AM -0300, Marcelo Tosatti wrote:
> > > 
> > > 
> > > On Fri, 27 Feb 2004, Jo Christian Buvarp wrote:
> > > 
> > > > No, I only got IBM ServeRAID support
> > > 
> > > Eric, my mistake. Nevermind it :)
> > > 
> > > Jo, Enrico,
> > > 
> > > The error is harmless, although it is a bug.
> > > 
> > > I suspect the ext2 2.6 compat updates on 2.4.25 might be causing this.
> > > I'll send you a patch privately to revert those and confirm (or not).
> 
