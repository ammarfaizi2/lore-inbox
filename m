Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbTF0Wab (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbTF0WaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:30:09 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:48295 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264868AbTF0W3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:29:53 -0400
Date: Fri, 27 Jun 2003 17:31:53 -0400
From: Ben Collins <bcollins@debian.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "David S. Miller" <davem@redhat.com>, mbligh@aracnet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
Message-ID: <20030627213153.GR501@phunnypharm.org>
References: <20030626.224739.88478624.davem@redhat.com> <21740000.1056724453@[10.10.2.4]> <Pine.LNX.4.55.0306270749020.4137@bigblue.dev.mcafeelabs.com> <20030627.143738.41641928.davem@redhat.com> <Pine.LNX.4.55.0306271454490.4457@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0306271454490.4457@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 03:02:00PM -0700, Davide Libenzi wrote:
> On Fri, 27 Jun 2003, David S. Miller wrote:
> 
> > No, this is the _BAD_ part, shit accumulates equally with
> > useful reports.
> >
> > Useful reports in non-bugtracking system environments get
> > retransmitted and eventually looked at.
> 
> David, your method is the dream of every software developer. Having Q/A
> repeatedly pushing the same issue. Having a track is good and flagging a
> report as not-a-bug or need-more-info takes almost the same time (if the
> system is sanely designed) it takes you to flag your message a shit. In
> this way though you do not lose things meaningful that you overlooked at
> first sight. And this comes from someone that wanted to quit his job when
> they forced for the first time to use a tracking system ;)

As a bug reporter, and as someone who receives bug reports, I can say
that on both ends I find it easier to send emails, and get emails than
to fiddle with any bug tracking tool.

I'm with Dave on this one. Scrap the nifty tools, and just use good
sense. Emails let each developer handle bug reports in their own way.
I'm sure you could make a nice local tool for yourself to manage your
own bug reports.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
