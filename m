Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWF2NgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWF2NgL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 09:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWF2NgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 09:36:11 -0400
Received: from pih-relay05.plus.net ([212.159.14.132]:38340 "EHLO
	pih-relay05.plus.net") by vger.kernel.org with ESMTP
	id S1750710AbWF2NgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 09:36:09 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Paolo Ornati <ornati@gmail.com>
Subject: Re: [PATCH] Documentation: remove duplicate cleanups
Date: Thu, 29 Jun 2006 14:35:39 +0100
User-Agent: KMail/1.9.3
Cc: jensmh@gmx.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, Paolo Ornati <ornati@fastwebnet.it>
References: <20060629134002.1b06257c@localhost> <200606291339.11733.s0348365@sms.ed.ac.uk> <20060629150545.167c0abb@localhost>
In-Reply-To: <20060629150545.167c0abb@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606291435.39879.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 June 2006 14:05, Paolo Ornati wrote:
> On Thu, 29 Jun 2006 13:39:11 +0100
>
> Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > On Thursday 29 June 2006 13:12, Paolo Ornati wrote:
> > > On Thu, 29 Jun 2006 14:02:18 +0200
> > >
> > > jensmh@gmx.de wrote:
> > > > > diff --git a/Documentation/block/as-iosched.txt
> > > > > b/Documentation/block/as-iosched.txt index 6f47332..ed24cdd 100644
> > > > > --- a/Documentation/block/as-iosched.txt
> > > > > +++ b/Documentation/block/as-iosched.txt
> > > > > @@ -111,7 +111,7 @@ or if the next request in the queue is "
> > > > >  just completed request, it is dispatched immediately.  Otherwise,
> > > > >  statistics (average think time, average seek distance) on the
> > > > > process that submitted the just completed request are examined.  If
> > > > > it seems -likely that that process will submit another request
> > > > > soon, and that
> > > >
> > > > old version is correct, I think.
> > >
> > > me too (I've exagerated a bit in killing duplicates ;)
> >
> > "that the process"
>
> Are you sure?
> To me it makes more sense the old one when read in the context.

Actually the context made me think otherwise, look:

"Otherwise, statistics (average think time, average seek distance) on **the** 
process that submitted the just completed.."

[snip]
> > I disagree. The cleanup's either an improvement, or the sentence should
> > be rewritten, "Before continuing with how to attach, detect and unload
> > the framebuffer.."
> >
> > I think if you're going to improve the quality of documentation, there's
> > no harm to make minor grammatical improvements. Duplicate words are
> > almost always a bad thing, and they really disrupt reading flow.
>
> Maybe, but I'll probably make more danger than anything.
>
> For now I just want to eliminate the wrong duplicates and keep the
> correct ones.

It's arguable whether there are any "correct" duplicates in a well formed 
sentence in English. However, I'm inclined to agree with "as few changes as 
possible", so disregard.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
