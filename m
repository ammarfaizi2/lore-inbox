Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281735AbRLGPDd>; Fri, 7 Dec 2001 10:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281780AbRLGPDY>; Fri, 7 Dec 2001 10:03:24 -0500
Received: from web13908.mail.yahoo.com ([216.136.175.71]:34569 "HELO
	web13908.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281735AbRLGPDU>; Fri, 7 Dec 2001 10:03:20 -0500
Message-ID: <20011207150319.89014.qmail@web13908.mail.yahoo.com>
Date: Fri, 7 Dec 2001 07:03:19 -0800 (PST)
From: Jorge Carminati <jcarminati@yahoo.com>
Subject: Re: Kernel freezing....
To: linux-kernel@vger.kernel.org
In-Reply-To: <E16CLPT-0005sN-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > In all the cases the compiled kernel had set exactly the same
> options,
> > **just changed the cpu optimization type**. Kernel version 2.4.16.
> > 
> > Conclusion: IMHO it´s a kernel bug. The same .config optimized for
> AMD
> > freezes, and Red Hat's default kernel does the same. Luckily for my
> > investment it´s not a memory bug.
> 
> The AMD K7 stuff will trigger hardware bugs on some VIA boards. We
> know
> that bit. Why the RH one crashes may be that or may be a different
> bug
> fixed between 2.4.9->16. 
> 
> Either way this is good news. The machine seems fine and the newer
> kernel
> seems to be behaving well.
> 
> Alan

Alan, 

Just one question: in a perfect world, as for the moment in this
notebook MK7 CPU optimization is not a choice, which should be the
highest recommended CPU optimization setting that I should try/run ? .

M586MMX 
M686  
MPENTIUMIII 
MK6 (my supposition)

Thanks in advance,
Jorge Carminati.

P.S: For any answer please CC to jcarminati@yahoo.com


__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
