Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVEYAzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVEYAzK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 20:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVEYAzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 20:55:09 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:14599 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262215AbVEYAzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 20:55:04 -0400
Date: Tue, 24 May 2005 17:59:42 -0700
To: Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>
Cc: Bill Huey <bhuey@lnxw.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
Message-ID: <20050525005942.GA24893@nietzsche.lynx.com>
References: <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu> <4292E559.3080302@yahoo.com.au> <20050524090240.GA13129@elte.hu> <4292F074.7010104@yahoo.com.au> <1116957953.31174.37.camel@dhcp153.mvista.com> <20050524224157.GA17781@nietzsche.lynx.com> <1116978244.19926.41.camel@dhcp153.mvista.com> <20050525001019.GA18048@nietzsche.lynx.com> <1116981913.19926.58.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116981913.19926.58.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 05:45:13PM -0700, Daniel Walker wrote:
> I think some of it is volatile still, but there are plenty of pieces
> that could go in now. Threaded interrupts is up for discussion, this is
> the reason why I started the thread. People appear to have specific
> objections to that feature, which are still not clear.
> 
> Whole patch, no, small chunks yes. 

You should have CCed Andrew originally.

All objections I've seen so far have been vague, from folks that
don't/or refuse to understand the fundamentals of how this patch
works nor has tracked the development of it carefully. Until
specific questions and objections are articulated, nothing can be
addressed at this time. I'm biased to ignoring all talk until
then.

bill

