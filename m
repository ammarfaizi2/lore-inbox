Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbTDLRPE (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 13:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbTDLRPD (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 13:15:03 -0400
Received: from tomts13.bellnexxia.net ([209.226.175.34]:26077 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263340AbTDLRPC (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 13:15:02 -0400
Date: Sat, 12 Apr 2003 13:22:22 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       John Bradford <john@grabjohn.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-English user messages
In-Reply-To: <1050161671.16385.0.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0304121307420.18684-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Apr 2003, Alan Cox wrote:

> On Sad, 2003-04-12 at 16:20, Chuck Ebbert wrote:
> > > /Documentation could be a lot better than it is...  Some of it
> > > is very out of date.
> > 
> > 
> >   You are being way too kind.
> > 
> >   /Documentation is *awful*.
> 
> You know where to submit contributions

this is, from a personal perspective, simply too timely to pass up. in
fact, i have submitted six different patches, all aimed at either
improving the documentation or cleaning up configuration menus.

without exception, every patch i have submitted directly has been dropped
without comment.  the only one that was eventually accepted (rearranged
filesystems menu) was because someone else with more authority and higher
up the kernel-hacker food chain was gracious enough to submit it on my
behalf.

yes, i've read the "SubmittingPatches" guide, and at the risk of offending
a few people, i find it pretty irritating, if not downright patronizing,
to suggest that one should *expect* to have patches dropped without
comment, and should *expect* to have to work hard at resubmitting the same
patch until it takes.

it's pretty counter-productive to suggest that there are a *number* of
reasons why a patch might be discarded -- does not apply cleanly, 
style issue, perhaps too trivial, what have you -- but not give any
indication as to what that reason might be.  am i supposed to go back
and take a closer look?  take a wild guess?  resubmit unchanged?

as someone who hasn't been here that long and is still feeling my 
way around, i can appreciate how much work it is to be responsible
for the numerous patches that are submitted.

but it seems more than a little hypocritical to invite patches to fix
things like documentation if those patches will just be tossed
unanswered.

if you'd like patches to improve things like menu layout or documentation,
let me know, i'll be glad to help.  if not, let me know that, too,  so i
can move on to other things and stop wasting my time.

rday


