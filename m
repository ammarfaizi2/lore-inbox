Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSE2Nnk>; Wed, 29 May 2002 09:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSE2Nnj>; Wed, 29 May 2002 09:43:39 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:57102 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315265AbSE2Nni>; Wed, 29 May 2002 09:43:38 -0400
Date: Wed, 29 May 2002 15:43:23 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: yodaiken@fsmlabs.com, linux-kernel@vger.kernel.org
Subject: Re: A reply on the RTLinux discussion.
In-Reply-To: <1022678678.4123.189.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0205291440420.17583-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29 May 2002, Alan Cox wrote:

> I've met Victor several times including having discussions over open
> source philosophy patents and the like. I think he is a good guy.

I can't judge about this, my judgement comes from how he treats the RTAI
developer.

> The
> patent grant says it can be used for GPL software. As a free software
> author I have no problems at all with Victor's patent.

GPL is not the only free software license.

> It might be anti
> how convenient I can mix the two and flog it for lots of money, but
> thats not free software anyway.

It's about "free speech" not "free beer".

> > Victor denies the RTAI people any clear answers about the license.
> 
> He told them that if they were not sure they should ask a lawyer. That
> sounds to me rather correct advice. What kind of answer do you expect.
> There are really only two that might be expected in such a situation,
> they I suspect go
> 
> 	"We think you need a license if you use proprietary software 
> 	 with this" and "Ask a lawyer"

1. We are talking about a free software project here!
2. They asked a lawyer, here is the result:
   http://lwn.net/2002/0131/a/rtai-24.1.8.php3
So according to this legal advice, normal application running under
RTLinux/RTAI are not infringing the patent and therefore need no license.
Victor now seems to see things different: "it would still not be permitted
to link binary modules into the derived program without our
permission.  RTAI "user space"  to me, does not escape this issue."
Such statements are what creates the uncertainty and Victor does nothing
to resolve this issue.
That RTAI can be used in a commercial or even closed source environment
doesn't matter here. I'm not happy about the binary module situation
either, but you have to take that to Linus. Whatever is allowed in user
space is clearly defined by the kernel license.
The RTAI developer have the right to use their work however they wish,
should there be a copyright problem, it should be correctly labeled as
such and definitely doesn't need a patent license.

bye, Roman

