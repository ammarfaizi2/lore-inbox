Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285468AbRLGTXs>; Fri, 7 Dec 2001 14:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285473AbRLGTXi>; Fri, 7 Dec 2001 14:23:38 -0500
Received: from web13906.mail.yahoo.com ([216.136.175.69]:8972 "HELO
	web13906.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S285472AbRLGTXW>; Fri, 7 Dec 2001 14:23:22 -0500
Message-ID: <20011207192321.6552.qmail@web13906.mail.yahoo.com>
Date: Fri, 7 Dec 2001 11:23:21 -0800 (PST)
From: Jorge Carminati <jcarminati@yahoo.com>
Subject: Re: Kernel freezing....
To: linux-kernel@vger.kernel.org
In-Reply-To: <3C11096E.9040102@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, thanks Mark and François for the answer.

I´ll stick to K6 and see what happends.

Regards,
jc


--- François Cami <stilgar2k@wanadoo.fr> wrote:
> 
> I would bet on K6, I've encountered that many times, K6
> seems to behave correctly, and you get the 3DNow! instructions
> that can come in handy.
> 
> François
> 
> Jorge Carminati wrote:
> 
> > --- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > 
> >>>In all the cases the compiled kernel had set exactly the same
> >>>
> >>options,
> >>
> >>>**just changed the cpu optimization type**. Kernel version 2.4.16.
> >>>
> >>>Conclusion: IMHO it´s a kernel bug. The same .config optimized for
> >>>
> >>AMD
> >>
> >>>freezes, and Red Hat's default kernel does the same. Luckily for
> my
> >>>investment it´s not a memory bug.
> >>>
> >>The AMD K7 stuff will trigger hardware bugs on some VIA boards. We
> >>know
> >>that bit. Why the RH one crashes may be that or may be a different
> >>bug
> >>fixed between 2.4.9->16. 
> >>
> >>Either way this is good news. The machine seems fine and the newer
> >>kernel
> >>seems to be behaving well.
> >>
> >>Alan
> >>
> > 
> > Alan, 
> > 
> > Just one question: in a perfect world, as for the moment in this
> > notebook MK7 CPU optimization is not a choice, which should be the
> > highest recommended CPU optimization setting that I should try/run
> ? .
> > 
> > M586MMX 
> > M686  
> > MPENTIUMIII 
> > MK6 (my supposition)
> > 
> > Thanks in advance,
> > Jorge Carminati.
> > 
> > P.S: For any answer please CC to jcarminati@yahoo.com
> > 
> > 
> > __________________________________________________
> > Do You Yahoo!?
> > Send your FREE holiday greetings online!
> > http://greetings.yahoo.com
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
> 
> 
> 


__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
