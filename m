Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281780AbRLBUyH>; Sun, 2 Dec 2001 15:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276369AbRLBUx6>; Sun, 2 Dec 2001 15:53:58 -0500
Received: from relay.softcomca.com ([168.144.1.67]:2835 "EHLO
	relay1.softcomca.com") by vger.kernel.org with ESMTP
	id <S279305AbRLBUxr> convert rfc822-to-8bit; Sun, 2 Dec 2001 15:53:47 -0500
X-Originating-IP: 208.191.192.54
X-URL: http://www.mail2web.com/
Subject: RE: Re: Coding style - a non-issue
From: "n7ekg@swbell.net" <n7ekg@swbell.net>
Date: Sun, 2 Dec 2001 15:53:46 -0500
To: "lm@bitmover.com" <lm@bitmover.com>,
        "vonbrand@sleipnir.valparaiso.cl" <vonbrand@sleipnir.valparaiso.cl>,
        "yodaiken@fsmlabs.com" <yodaiken@fsmlabs.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: n7ekg@swbell.net
X-Priority: 3
X-MSMail-Priority: Normal
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Mailer: JMail 3.7.0 by Dimac (www.dimac.net)
Message-ID: <RELAY1LpTVzF25mIaCG00000ed2@relay1.softcomca.com>
X-OriginalArrivalTime: 02 Dec 2001 20:53:53.0194 (UTC) FILETIME=[737A60A0:01C17B73]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been following this thread with a mixture of amusement and exasperation - amusement that intelligent people like Linus, who ought to know better, are spouting this evolution stuff, and exasperation that some people think that because someone's an expert in one thing, they are an expert in all things.

The idea of genetic evolution itself is complete nonsense - biological systems don't evolve genetically, they evolve environmentally.  Biological systems change as a result of random mutation, and what doesn't work doesn't survive.  What people try to pass off as evolution is simply the less fit not surviving to pass on their bad genes.  Sort of like the hundred monkeys idea.

But that is all completely irrelevent to coding, since it is extremely inefficient for systems to "evolve" based on trial and error.  The way modern systems evolve is based on (hopefully) *intelligent* selection - I write a patch, submit it to Linus.  He doesn't accept it, throw it in the kernel, and that's it - he looks at it, what it does, and decides if it fits in the Grand Scheme of things - kernel efficiency, speed, flexibility, extensability, and maintainability - and *then* decides if it makes it in.  They key difference is that in nature, mutation is random because it can afford to be - in coding, it isn't because we don't have thousands or millions of years to find out whether or not something works or not.

That being said, I am well aware that "genetic programming" has made some progress in that direction, mainly because it doesn't take millenia to figure out what works and what doesn't.  But that's a long way from "evolving" an entire operating system.  I don't believe for a moment that homo sapiens "evolved" from pond scum although I might believe that some fellow homo sapiens *are* pond scum!) - it only makes sense that we are a created species, and that Homo Erectus ans all the rest were early genetic experiments.  Who created homo sapiens is beyond the scope of this discussion ;)

Original Message:
-----------------
From: Larry McVoy lm@bitmover.com
Date: Sun, 02 Dec 2001 12:25:26 -0800
To: vonbrand@sleipnir.valparaiso.cl, yodaiken@fsmlabs.com, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue


On Sat, Dec 01, 2001 at 08:18:06PM -0300, Horst von Brand wrote:
> Victor Yodaiken <yodaiken@fsmlabs.com> said:
> > Linux is what it is because of design, not accident. And you know
> > that better than anyone.
> 
> I'd say it is better because the mutations themselves (individual patches)
> go through a _very_ harsh evaluation before being applied in the "official"
> sources. 

Which is exactly Victor's point.  That evaluation is the design.  If the 
mutation argument held water then Linus would apply *ALL* patches and then
remove the bad ones.  But he doesn't.  Which just goes to show that on this
mutation nonsense, he's just spouting off.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--------------------------------------------------------------------
mail2web - Check your email from the web at
http://mail2web.com/ .

