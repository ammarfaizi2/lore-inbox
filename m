Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVBRHyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVBRHyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 02:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVBRHyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 02:54:46 -0500
Received: from simmts6.bellnexxia.net ([206.47.199.164]:32649 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261301AbVBRHyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 02:54:43 -0500
Message-ID: <1451.10.10.10.24.1108713140.squirrel@linux1>
In-Reply-To: <200502180142.j1I1gJXC007648@laptop11.inf.utfsm.cl>
References: Message from "Sean" <seanlkml@sympatico.ca> of "Thu, 17 Feb 2005
    16:24:01 CDT." <4912.10.10.10.24.1108675441.squirrel@linux1>
    <200502180142.j1I1gJXC007648@laptop11.inf.utfsm.cl>
Date: Fri, 18 Feb 2005 02:52:20 -0500 (EST)
Subject: Re: [BK] upgrade will be needed
From: "Sean" <seanlkml@sympatico.ca>
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Cc: "Chris Friesen" <cfriesen@nortel.com>, "d.c" <aradorlinux@yahoo.es>,
       tytso@mit.edu, cs@tequila.co.jp, galibert@pobox.com,
       kernel@crazytrain.com, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-7
X-Mailer: SquirrelMail/1.4.3a-7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, February 17, 2005 8:42 pm, Horst von Brand said:

> Linus clearly considered not just his /own/ workflow, but the workflow
> for the /whole/ kernel development community. In fact, BK was designed

Well, the /whole/ community isn't yet included, that's what we're talking
about.

> around the requirements Linus and other head hackers laid down for a
> SCM for use in Linux. And I'm quite sure that if Linus et al had
> serious misgivings about the license somehow hindering Linux
> development, they would have got it fixed or dumped BK. Linus has
> said time and again that he  just cares for the very best kernel
> possible, nothing else.

Do you think that the developers who must or want to use other SCM tools
desire less?

> Sure, from the periphery of kernel development using something else looks
> simple. But you have to consider there are literaly dozens of trees (of
> the head maintainers) exchanging changesets. The flow of going into
> 2.6 is astonishing right now, I'd say some 3 or 5 times more than
> what got into the most furious 2.3 patch frenzies. Existing open
> source tools just aren't up to the task, as Linus has repeatedly said.

There are ways that the tools could coexist and work together better than
they do today. If people would stop acting like BK was in jeopardy of
being taken away from them and realize that others just want the ability
to use their tools of choice too.

> Just now there are starting to be halfways useful SCM systems (almost
> all based on the "one central repository" idea, which doesn't cut it
> for Linux), but they aren't proven enough.

Yeah, there are some glimmers of hope for sure, but you're right they're a
ways off.

Sean



