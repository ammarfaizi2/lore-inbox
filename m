Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbUCAO61 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 09:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbUCAO61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 09:58:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9658 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261322AbUCAO6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 09:58:25 -0500
Date: Mon, 01 Mar 2004 10:01:13 -0500
From: Enrico Demarin <enricod@videotron.ca>
Subject: Re: Ibm Serveraid Problem with 2.4.25
In-reply-to: <20040301033017.GD1270@ait.ac.th>
To: Alain Fauconnet <alain@ait.ac.th>
Cc: linux-kernel@vger.kernel.org
Message-id: <1078153079.4447.2.camel@localhost.localdomain>
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
 <1078110630.4446.87.camel@localhost.localdomain>
 <20040301033017.GD1270@ait.ac.th>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alain , I am pasting you an email i got from Marcelo Tosatti, which I
think clarifies pretty well the history of 2.4.24 and 2.4.25 :

-- snip --

2.4.24 was under development (had -pre1, -pre2 and -pre3 released). 

At that point, we had to release 2.4.24 without the "-pre" changes (only
with the security fixes). 

So basically 2.4.24-pre was renamed to 2.4.25-pre, and 2.4.25-pre4 was 
released.

-- snip --

- Enrico

On Sun, 2004-02-29 at 22:30, Alain Fauconnet wrote:
> Enrico,
> 
> Thanks for the update, but...
> 
> On Sun, Feb 29, 2004 at 10:10:30PM -0500, Enrico Demarin wrote:
> > Alain,
> > 
> > so far Jo went through all the pre2.4.24 and 25 and the bug appeared
> > in 2.4.24pre1. 
> 
> Are you meaning that  the  bug  was  already  present  in  the  2.4.24
> release? I'm  a bit confused here.


