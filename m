Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbUB0NsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbUB0NsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:48:09 -0500
Received: from 64-186-161-006.cyclades.com ([64.186.161.6]:19659 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262869AbUB0NsF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:48:05 -0500
Date: Fri, 27 Feb 2004 11:36:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Jo Christian Buvarp <jcb@svorka.no>
Cc: Enrico Demarin <enricod@videotron.ca>,
       "Moore, Eric Dean" <Emoore@lsil.com>, linux-kernel@vger.kernel.org
Subject: Re: Ibm Serveraid Problem with 2.4.25
In-Reply-To: <403EEEB9.5030408@svorka.no>
Message-ID: <Pine.LNX.4.58L.0402271133220.18055@logos.cnet>
References: <403DB882.9000401@svorka.no> <1077839333.4823.5.camel@localhost.localdomain>
 <1077846502.4454.2.camel@localhost.localdomain> <Pine.LNX.4.58L.0402270011140.2029@logos.cnet>
 <403EEEB9.5030408@svorka.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Feb 2004, Jo Christian Buvarp wrote:

> No, I only got IBM ServeRAID support

Eric, my mistake. Nevermind it :)

Jo, Enrico,

The error is harmless, although it is a bug.

I suspect the ext2 2.6 compat updates on 2.4.25 might be causing this.
I'll send you a patch privately to revert those and confirm (or not).


