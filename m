Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270401AbRHWVNU>; Thu, 23 Aug 2001 17:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270382AbRHWVMa>; Thu, 23 Aug 2001 17:12:30 -0400
Received: from mx6.port.ru ([194.67.57.16]:59403 "EHLO mx6.port.ru")
	by vger.kernel.org with ESMTP id <S270359AbRHWVMS>;
	Thu, 23 Aug 2001 17:12:18 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.27.173]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15a1mD-000M4n-00@f10.mail.ru>
Date: Fri, 24 Aug 2001 01:12:33 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The main reason to include it, is that that's what it was done in.
> If you go back and read the archives, ESR goes over why all sorts of
> other languages wouldn't work as easily.
in such cases the solution is to elaborate, and not to
leave things to decay.

> That wasn't my point at all.  My point was that if you're somehow
> transfering the 21mb source .tar.bz2'ed, you can also stand to transport
> the 4mb of python 2.0.1 source, tar.gz'ed over as well.  In other words,
> having to bring python over any of the methods that Jes mentioned isn't
> any more painful than the kernel source.  It's roughly the size of a couple
> of vmlinux'es.
  i was sarcastic here. actually the fact is that
  4MB of tarred sources is more than 10 .c files
  doing the same thing 1.5x times faster.

> Have you tried cml2 on your p166?  ESR went and did much speed tweaking of
> the code about 6 months ago it seems like and managed to please some of the
> people using a low-end pentium.  Building a kernel on a 386 isn't approcaching
> tolerable right now anyhow.  Someone pointed out today or yesterday it takes
> ~10 days.
  it is not an excuse to make things even worser.
 
> Python is no harder to maintain then C.
  actually i meant that "i hardly can believe that
  c in such task is harder to maintain than python".

---


cheers,


   Samium Gromoff
