Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287319AbSACOxh>; Thu, 3 Jan 2002 09:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287330AbSACOx1>; Thu, 3 Jan 2002 09:53:27 -0500
Received: from nfs1.infosys.tuwien.ac.at ([128.131.172.16]:29660 "EHLO
	infosys.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S287319AbSACOxR>; Thu, 3 Jan 2002 09:53:17 -0500
Date: Thu, 3 Jan 2002 15:47:18 +0100
From: Thomas Gschwind <tom@infosys.tuwien.ac.at>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Nathan Bryant <nbryant@allegientsystems.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: i810_audio]
Message-ID: <20020103154718.C32419@infosys.tuwien.ac.at>
In-Reply-To: <3C3382CA.3000503@allegientsystems.com> <3C345493.5040800@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C345493.5040800@evision-ventures.com>; from dalecki@evision-ventures.com on Thu, Jan 03, 2002 at 01:54:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 01:54:43PM +0100, Martin Dalecki wrote:
> Nathan Bryant wrote:
> > Can you have a look at Doug Ledford's 0.13 driver? this incorporates 
> > most or all of the fixes you mentioned, except for SiS support, and 
> > some other fixes; it hasn't been incorporated into the main kernel 
> > quite yet because it needs more testing. 
> 
> 
> Let me allow for a bit of advertising... Hist SiS changes work fine for 
> me with the exception
> of recording.,

I did not have the pointer to Doug's latest version of the i810
driver.  I will integrate my patches into his latest version and will
send it to the list.  I will also have another look at recording but
it would be great if you could be a little bit more specific of your
recording results.

What happened? 
  How did you try to record?
  Did the system crash?  
  Did the program you used for recording crash?
  Was the recording trash?  
  How did it sound?  To fast? To slow? Crackling? Random noise? All of it?
  What hardware do you have?  K7S5A or a different MB with a SiS735 chipset? 

Thanks,
Thomas
-- 
Thomas Gschwind                      Email: tom@infosys.tuwien.ac.at
Technische Universit‰t Wien
Argentinierstraﬂe 8/E1841            Tel: +43 (1) 58801 ext. 18412
A-1040 Wien, Austria, Europe         Fax: +43 (1) 58801 ext. 18491
