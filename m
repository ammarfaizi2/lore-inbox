Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbUCACKV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 21:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbUCACKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 21:10:20 -0500
Received: from mail-gate.ait.ac.th ([202.183.214.47]:54492 "EHLO
	mail-gate.ait.ac.th") by vger.kernel.org with ESMTP id S262220AbUCACKQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 21:10:16 -0500
Date: Mon, 1 Mar 2004 09:10:14 +0700
From: Alain Fauconnet <alain@ait.ac.th>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jo Christian Buvarp <jcb@svorka.no>, Enrico Demarin <enricod@videotron.ca>,
       "Moore, Eric Dean" <Emoore@lsil.com>, linux-kernel@vger.kernel.org
Subject: Re: Ibm Serveraid Problem with 2.4.25
Message-ID: <20040301021014.GA1270@ait.ac.th>
References: <403DB882.9000401@svorka.no> <1077839333.4823.5.camel@localhost.localdomain> <1077846502.4454.2.camel@localhost.localdomain> <Pine.LNX.4.58L.0402270011140.2029@logos.cnet> <403EEEB9.5030408@svorka.no> <Pine.LNX.4.58L.0402271133220.18055@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0402271133220.18055@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 11:36:51AM -0300, Marcelo Tosatti wrote:
> 
> 
> On Fri, 27 Feb 2004, Jo Christian Buvarp wrote:
> 
> > No, I only got IBM ServeRAID support
> 
> Eric, my mistake. Nevermind it :)
> 
> Jo, Enrico,
> 
> The error is harmless, although it is a bug.
> 
> I suspect the ext2 2.6 compat updates on 2.4.25 might be causing this.
> I'll send you a patch privately to revert those and confirm (or not).
> 

Folks,

Please followup to the list when you've drawn conclusions  about  this
issue.
I'm holding a 2.4.25 upgrade of a busy mail server because of this.

Greets,
_Alain_
