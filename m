Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVEYBDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVEYBDS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 21:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVEYBDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 21:03:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:49903 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262216AbVEYBDK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 21:03:10 -0400
Subject: Re: RT patch acceptance
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Bill Huey <bhuey@lnxw.com>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, sdietrich@mvista.com
In-Reply-To: <20050525005942.GA24893@nietzsche.lynx.com>
References: <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu>
	 <4292E559.3080302@yahoo.com.au> <20050524090240.GA13129@elte.hu>
	 <4292F074.7010104@yahoo.com.au>
	 <1116957953.31174.37.camel@dhcp153.mvista.com>
	 <20050524224157.GA17781@nietzsche.lynx.com>
	 <1116978244.19926.41.camel@dhcp153.mvista.com>
	 <20050525001019.GA18048@nietzsche.lynx.com>
	 <1116981913.19926.58.camel@dhcp153.mvista.com>
	 <20050525005942.GA24893@nietzsche.lynx.com>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 24 May 2005 18:02:57 -0700
Message-Id: <1116982977.19926.63.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-24 at 17:59 -0700, Bill Huey wrote:
> On Tue, May 24, 2005 at 05:45:13PM -0700, Daniel Walker wrote:
> > I think some of it is volatile still, but there are plenty of pieces
> > that could go in now. Threaded interrupts is up for discussion, this is
> > the reason why I started the thread. People appear to have specific
> > objections to that feature, which are still not clear.
> > 
> > Whole patch, no, small chunks yes. 
> 
> You should have CCed Andrew originally.

He was CC'd on the very first email. It could be that he isn't going to
get involved cause Ingo already said he's not submitting anything .. 

> All objections I've seen so far have been vague, from folks that
> don't/or refuse to understand the fundamentals of how this patch
> works nor has tracked the development of it carefully. Until
> specific questions and objections are articulated, nothing can be
> addressed at this time. I'm biased to ignoring all talk until
> then.

I'm not going to ignore any of the discussion, but it would be nice to
hear Andrew's, or Linus's specific objections..

Daniel

