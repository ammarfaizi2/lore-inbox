Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUCADIH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 22:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbUCADIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 22:08:07 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21632 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262226AbUCADIE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 22:08:04 -0500
Date: Sun, 29 Feb 2004 22:10:30 -0500
From: Enrico Demarin <enricod@videotron.ca>
Subject: Re: Ibm Serveraid Problem with 2.4.25
In-reply-to: <20040301021014.GA1270@ait.ac.th>
To: Alain Fauconnet <alain@ait.ac.th>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Jo Christian Buvarp <jcb@svorka.no>,
       "Moore, Eric Dean" <Emoore@lsil.com>, linux-kernel@vger.kernel.org
Message-id: <1078110630.4446.87.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7)
Content-type: text/plain; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
References: <403DB882.9000401@svorka.no>
 <1077839333.4823.5.camel@localhost.localdomain>
 <1077846502.4454.2.camel@localhost.localdomain>
 <Pine.LNX.4.58L.0402270011140.2029@logos.cnet> <403EEEB9.5030408@svorka.no>
 <Pine.LNX.4.58L.0402271133220.18055@logos.cnet>
 <20040301021014.GA1270@ait.ac.th>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alain,

so far Jo went through all the pre2.4.24 and 25 and the bug appeared
in 2.4.24pre1. 

- Enrico


On Sun, 2004-02-29 at 21:10, Alain Fauconnet wrote:
> On Fri, Feb 27, 2004 at 11:36:51AM -0300, Marcelo Tosatti wrote:
> > 
> > 
> > On Fri, 27 Feb 2004, Jo Christian Buvarp wrote:
> > 
> > > No, I only got IBM ServeRAID support
> > 
> > Eric, my mistake. Nevermind it :)
> > 
> > Jo, Enrico,
> > 
> > The error is harmless, although it is a bug.
> > 
> > I suspect the ext2 2.6 compat updates on 2.4.25 might be causing this.
> > I'll send you a patch privately to revert those and confirm (or not).


