Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264018AbTEFSj1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbTEFSj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:39:27 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:58379 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264018AbTEFSjZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:39:25 -0400
Date: Tue, 6 May 2003 14:44:49 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Felix von Leitner <felix-kernel@fefe.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.68] Scalability issues
In-Reply-To: <3EB66F8C.8050402@nortelnetworks.com>
Message-ID: <Pine.LNX.3.96.1030506142904.9452D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003, Chris Friesen wrote:

> Felix von Leitner wrote:
> > Thus spake David S. Miller (davem@redhat.com):
> 
> >>Either reproduce without the nvidia module loaded, or take
> >>your report to nvidia.
> >>
> > 
> > Thank you for this stunning display of unprofessionalism and zealotry.
> > People like you keep free software alive.
> 
> He may not have put it as politely as you would like, but there really is no way 
> to debug a problem in a kernel which has been tainted by binary-only drivers. 
> That driver could have done literally anything to the kernel on loading.

There's no need to be rude in any case, particularly after the OP reposted
a not tainted oops which had been through ksymoops and didn't get any help
anyway. Why be nasty about the format of a question you're not answering
even after it's been asked again in the preferred format?

It's a shame that some people seem to think that lots of hard work
entitles them to be rude and condescending, while really important
contributors like Alan Cox, Ingo and akpm can be polite and helpful, even
when they are correcting someone or disagreeing on an approach to a
problem.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

