Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319235AbSIFPxO>; Fri, 6 Sep 2002 11:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319234AbSIFPxO>; Fri, 6 Sep 2002 11:53:14 -0400
Received: from [212.3.242.3] ([212.3.242.3]:4598 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S319235AbSIFPxN>;
	Fri, 6 Sep 2002 11:53:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: jbradford@dial.pipex.com
Subject: Re: ide drive dying?
Date: Fri, 6 Sep 2002 17:55:06 +0200
User-Agent: KMail/1.4.1
References: <200209061536.g86FaniW004326@darkstar.example.net>
In-Reply-To: <200209061536.g86FaniW004326@darkstar.example.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209061755.06344.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 September 2002 17:36, jbradford@dial.pipex.com wrote:
> > I've looked up these errors on the net, and as far as i can tell it means
> > that the drive has some bad sectors at the given addresses and that it
> > will probably die on me sooner or later.
> >
> > Can someone either confirm this to me or tell me what to do to fix it?
> >
> > The drive involved is an IBM-DTLA-307060, which has served me without
> > problems now for about 2 years.
>
> Have a look at:
>
> http://csl.cse.ucsc.edu/smart.shtml
>
> there you will find software for interrogating and monitoring the
> S.M.A.R.T. data available from your drive.  It's a little late to start
> monitoring it, if the drive is already dying, but if, for example, it shows
> a lot of re-allocated sectors, or spin retries, you'll know something is
> wrong.
>

OK, I downloaded that and installed it, but well, frankly, it shows me very 
little useful stuff.

Or i'm just not good at interpreting this.

DK

-- 
"I gained nothing at all from Supreme Enlightenment, and for that very
reason it is called Supreme Enlightenment."
		-- Gotama Buddha

