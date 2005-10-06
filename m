Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbVJFNHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbVJFNHy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 09:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbVJFNHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 09:07:54 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:54504 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S1750868AbVJFNHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 09:07:53 -0400
Message-ID: <43452134.4010504@cs.aau.dk>
Date: Thu, 06 Oct 2005 15:05:56 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: freebox possible GPL violation
References: <20051005111329.GA31087@linux.ensimag.fr> <4343B779.8030200@cs.aau.dk> <1128511676.2920.19.camel@laptopd505.fenrus.org> <4343BB04.7090204@cs.aau.dk> <1128513584.2920.23.camel@laptopd505.fenrus.org> <4343C0DB.9080506@cs.aau.dk> <1128514062.2920.27.camel@laptopd505.fenrus.org> <4343C73E.9000507@cs.aau.dk> <20051006000741.GC18080@aitel.hist.no> <Pine.LNX.4.62.0510051741310.14560@qynat.qvtvafvgr.pbz> <4344EC64.2010400@aitel.hist.no> <4344F39B.10806@cs.aau.dk> <43450CE5.50302@aitel.hist.no>
In-Reply-To: <43450CE5.50302@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
>
> Well, but there still is a kernel in the box that was downloaded before
> they bought it?  Or does the box become unuseable when they buy it?

No idea, I don't have a Freebox yet.

> If I make a business out of lending windows boxes, then I have to pay
> licences
> on each box.  If I lend customers linux boxes, I should lend them the
> source too if they
> requests it.  Remember, even if the average customer doesn't know what
> software
> is in the box, they still have the right to make a copy of the linux
> kernel, because you
> cannot take away that right.

You got an extremely good point here. At least it shows why this way of
doing is not "moral", but, looking at the GPL text, there is nothing
stating any obligation to "pay" in any manner (money or contributions)
to use and/or modify GPLed softwares.

Just to illustrate my point, in the case of an webserver, if the
webmaster patch the code of his own webserver to provides his customers
with a new service. Has he the obligation to redistribute this code ?
Namely, his patched webserver will never get distributed. The only
interaction between the customers and his webserver will be through
exchanges of HTML files.

And anyway, to whom redistribute the code ? Indeed, what would do the
customers with such code ? As they are only using the service without
really touching the software.

Therefore, it would be nice from the webmaster to contribute with his
patch, but I do think that it is his own choice to do so.

Note: Originally, the redistribution of the code was mainly to avoid
customers or companies to get stuck with a "no more maintained"
binaries. In the case we are looking now, as the hardware is not
belonging to the customers, there is no such risk. So the protection
seems to be against something else... but what ?

> There have at least been cases where companies were selling
> linux-powered products, and were told that they had to
> provide the sources.  I don't know if any of them bothered
> going to court, simply making the source available (on a cd
> or webserver) is so much cheaper than that.

LinkSys is an example. But the customers were owning the machine with
everything in it (including the OS). Again, the clause on distributing
the sources help to not get stuck with a piece of hardware that you own
with no possibility of upgrade (remembers me the famous story of RMS and
the laser printer).

> An interesting thing about the GPL is that it talks about
> "distributing copies", not about "selling or otherwise changing ownership".
> 
> "Distributing" a linux kernel embedded in a product owned by the
> company doesn't change that.  Where the binary kernel go, the
> source should go too (if requested).
> 
> Fortunately, this licencing term is so easy to satisfy that it'd be silly
> to try to fight it. Stick the source on a webserver somewhere.  Provide
> the URL in the accompagnying paper (or a README file if appropriate.)
> If distributing cd's, consider sticking a tarball there.

Well, I'm really sorry to play the Devil Advocate once time more, but as
far as I know all these DSL companies have big secrets because of
weaknesses in their security. Being hacked at the Internet level is one
thing, being hacked at the DSLAM level means a lot. Try to imagine if
anybody could upload to you his own modified kernel, this means that you
can tape all the internet traffic, all the phone calls, all the TV
programs that you are looking at, and also probably having an easy way
in to your local network (wired and wifi).

Regards
-- 
Emmanuel Fleury

Live as if your were to die tomorrow.
Learn as if you were to live forever.
  -- Mahatma Gandhi
