Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbVJFORs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbVJFORs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbVJFORs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:17:48 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:21222 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750973AbVJFORr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:17:47 -0400
Message-ID: <43453277.9020900@aitel.hist.no>
Date: Thu, 06 Oct 2005 16:19:35 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Emmanuel Fleury <fleury@cs.aau.dk>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: freebox possible GPL violation
References: <20051005111329.GA31087@linux.ensimag.fr> <4343B779.8030200@cs.aau.dk> <1128511676.2920.19.camel@laptopd505.fenrus.org> <4343BB04.7090204@cs.aau.dk> <1128513584.2920.23.camel@laptopd505.fenrus.org> <4343C0DB.9080506@cs.aau.dk> <1128514062.2920.27.camel@laptopd505.fenrus.org> <4343C73E.9000507@cs.aau.dk> <20051006000741.GC18080@aitel.hist.no> <Pine.LNX.4.62.0510051741310.14560@qynat.qvtvafvgr.pbz> <4344EC64.2010400@aitel.hist.no> <4344F39B.10806@cs.aau.dk> <43450CE5.50302@aitel.hist.no> <43452134.4010504@cs.aau.dk>
In-Reply-To: <43452134.4010504@cs.aau.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Fleury wrote:

>Helge Hafting wrote:
>  
>
>>If I make a business out of lending windows boxes, then I have to pay
>>licences
>>on each box.  If I lend customers linux boxes, I should lend them the
>>source too if they
>>requests it.  Remember, even if the average customer doesn't know what
>>software
>>is in the box, they still have the right to make a copy of the linux
>>kernel, because you
>>cannot take away that right.
>>    
>>
>
>You got an extremely good point here. At least it shows why this way of
>doing is not "moral", but, looking at the GPL text, there is nothing
>stating any obligation to "pay" in any manner (money or contributions)
>to use and/or modify GPLed softwares.
>
>Just to illustrate my point, in the case of an webserver, if the
>webmaster patch the code of his own webserver to provides his customers
>with a new service. Has he the obligation to redistribute this code ?
>  
>
No, because he didn't distribute any binary code. 

>Namely, his patched webserver will never get distributed. The only
>interaction between the customers and his webserver will be through
>exchanges of HTML files.
>  
>
Correct, so only the licence on the html files (if any) will matter.

>Therefore, it would be nice from the webmaster to contribute with his
>patch, but I do think that it is his own choice to do so.
>  
>
Indeed, because he didn't distribute the webserver binary
in any way. He still only got his own single (modified) copy.
So he has choice.  But if he starts selling "improved webserver boxes"
then the GPL kicks in.  Source too - the price of getting the sw for
no money in the first place.

>Note: Originally, the redistribution of the code was mainly to avoid
>customers or companies to get stuck with a "no more maintained"
>binaries. In the case we are looking now, as the hardware is not
>belonging to the customers, there is no such risk. So the protection
>seems to be against something else... but what ?
>  
>
The point is forced open source.  If you can do business using
open-source stuff, then you shall be unable to prevent others from
doing the same.  This is the "price" of open source, and keeps the
sw prices way down.  Nobody can charge much for the open software
component, because the source must be available for free so
anybody capable of compiling it can create their own product.

Competition and the ability to make money then, is not about
having the best sw (because it is forcibly not secret) but in
providing the best service and hardware.

>>There have at least been cases where companies were selling
>>linux-powered products, and were told that they had to
>>provide the sources.  I don't know if any of them bothered
>>going to court, simply making the source available (on a cd
>>or webserver) is so much cheaper than that.
>>    
>>
>
>LinkSys is an example. But the customers were owning the machine with
>everything in it (including the OS). Again, the clause on distributing
>the sources help to not get stuck with a piece of hardware that you own
>with no possibility of upgrade (remembers me the famous story of RMS and
>the laser printer).
>  
>
Not getting stuck is one thing.  Not needing to reinvent the wheel
is another.  Nobody need to make another linux kernel from scratch, they
can instead grab the existing one and build on that.  In the long run, this
saves a lot of reimplementation cost for society.  Instead, whe can focus on
improving the software further.

>>An interesting thing about the GPL is that it talks about
>>"distributing copies", not about "selling or otherwise changing ownership".
>>
>>"Distributing" a linux kernel embedded in a product owned by the
>>company doesn't change that.  Where the binary kernel go, the
>>source should go too (if requested).
>>
>>Fortunately, this licencing term is so easy to satisfy that it'd be silly
>>to try to fight it. Stick the source on a webserver somewhere.  Provide
>>the URL in the accompagnying paper (or a README file if appropriate.)
>>If distributing cd's, consider sticking a tarball there.
>>    
>>
>
>Well, I'm really sorry to play the Devil Advocate once time more, but as
>far as I know all these DSL companies have big secrets because of
>weaknesses in their security. Being hacked at the Internet level is one
>thing, being hacked at the DSLAM level means a lot. Try to imagine if
>anybody could upload to you his own modified kernel, this means that you
>can tape all the internet traffic, all the phone calls, all the TV
>programs that you are looking at, and also probably having an easy way
>in to your local network (wired and wifi).
>  
>
Well, then they need to secure their DSLAM setup.  If it is at all
vulnerable this way, then they need to fix it.  Most users may be
"computer dummies", but there are enough experts among them too.
It only takes one leak, breakin, or reverse engineering session to
break through security-by-obscurity.  And when the cat is out of the
bag, it is out forever.

The internet level is secure enough, when set up by competent people.
Surely the same can be done at DSLAM level.  This reminds me of ethernet
many years ago, when people realized the possibilities of a hacked network
driver.  (A simple way to sniff all traffic, and inject spoofed traffic.)
Easy to do these days, with a open-source kernel.
But these problems are solved - mostly with encryption to protect
what must not be sniffed, and firewall routers preventing the routing
of spoofed packets. With a good setup, spoofing is limited to
spoof other machines on the same network, and then the local
admin can set things straight.

Bad security is not an excuse for disobeying the GPL.  The GPL itself states
that there are no exceptions. If "other concerns" means you can't obey
the GPL to the letter, then you _must_ refrain from distributing the
GPLed software altogether.  In such cases, the open software is not a 
legal option.

Very similiar to a company that cannot afford to pay licences - in that case
proprietary sw is not an option.  They can't just pirate anyway and get away
with it because "otherwise their business model won't work and result in 
bankrupcy".
If you can't take the "cost" of open sw, then don't use it.  
Fortunately, the cost is
usually low.  And they _can_ keep a linux device driver secret, they 
merely have to offer
the source for the rest of the kernel.

Helge Hafting
