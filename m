Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263346AbRFGV4W>; Thu, 7 Jun 2001 17:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263338AbRFGV4C>; Thu, 7 Jun 2001 17:56:02 -0400
Received: from laxmls03.socal.rr.com ([24.30.163.17]:22201 "EHLO
	laxmls03.socal.rr.com") by vger.kernel.org with ESMTP
	id <S263294AbRFGVzz>; Thu, 7 Jun 2001 17:55:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Shane Nay <shane@minirl.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Break 2.4 VM in five easy steps
Date: Thu, 7 Jun 2001 14:55:51 -0700
X-Mailer: KMail [version 1.2]
Cc: "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0106071659400.1156-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0106071659400.1156-100000@freak.distro.conectiva>
MIME-Version: 1.0
Message-Id: <0106071455511D.32519@compiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 June 2001 13:00, Marcelo Tosatti wrote:
> On Thu, 7 Jun 2001, Shane Nay wrote:
> > (Oh, BTW, I really appreciate the work that people have done on the VM,
> > but folks that are just talking..., well, think clearly before you impact
> > other people that are writing code.)
>
> If all the people talking were reporting results we would be really happy.
>
> Seriously, we really lack VM reports.

Okay, I've had some problems with the VM on my machine, what is the most 
usefull way to compile reports for you?  I have modified the kernel for a few 
different ports fixing bugs, and device drivers, etc., but the VM is all 
greek to me, I can just see that caching is hyper aggressive and doesn't look 
like it's going back to the pool..., which results in sluggish performance.  
Now I know from the work that I've done that anecdotal information is almost 
never even remotely usefull.  Therefore is there any body of information that 
I can read up on to create a usefull set of data points for you or other VM 
hackers to look at?  (Or maybe some report in the past that you thought was 
especially usefull?)

Thank You,
Shane Nay.
(I have in the past had many problems with the VM on embedded machines as 
well, but I'm not actively working on any right this second..., though my 
Psion is sitting next to me begging for me to run some VM tests on it :)
