Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVIEDmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVIEDmN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 23:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbVIEDmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 23:42:13 -0400
Received: from web50213.mail.yahoo.com ([206.190.39.188]:29077 "HELO
	web50213.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932182AbVIEDmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 23:42:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=qptVmH8lF1FE7dgbgm1gjvy2DtiOnkf5oZtKa/HwxGXjXG0ocXVQ8gcVI0WOfOJRaUk/1y3wWkA6WZg/yzFjQhjQD2UE9WTS8oBGSlHB9xJn6YihZ+YOGRuyooKQj0Ro63XNgYM6DguznAxPWHh5+IQ4nqeIS5Myt2tt/65slWg=  ;
Message-ID: <20050905034158.97152.qmail@web50213.mail.yahoo.com>
Date: Sun, 4 Sep 2005 20:41:58 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: re: RFC: i386: kill !4KSTACKS
To: Sean <seanlkml@sympatico.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <36918.10.10.10.10.1125889201.squirrel@linux1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Sean <seanlkml@sympatico.ca> wrote:

> On Sun, September 4, 2005 10:29 pm, Alex Davis said:
> 
> > Linux isn't just used by kernel developers. It's that attitude that
> > helps insure Linux will always have a small userbase. Lack of numbers
> > just gives the manufacturers another reason not to care about us. Joe
> > User doesn't care about our philosophical issues, nor should he. When
> > I install Linux on someone's machine, he wants it to work NOW, not in
> > some 'perfect-world' future.
> 
> Alex,
> 
> 
> Please stop the hand wringing over not being able to convince Joe User to
> install Linux today.  It will happen naturally when it's appropriate,
It will never be 'appropriate' if the system doesn't somehow work on Joe's
hardware. We currently have something that works. In my opinion it's
pointless to take that away. The manufacturers will still stone-wall us
regardless of ndiswrapper's existence. They were doing it before ndis-
wrapper existed.

> Linux is steadily growing in power and acceptance without binary drivers. 
> Trying to artificially speed up the process by destroying the very thing
> that makes Linux an important force is actually counterproductive.
Please explain how Linux can be an 'important force' if people can't
use it? Wireless networking is very important to people.

> It's not a philosophical issue, it's what Linux _is_: an open source
> operating system! That's what the developers are working on; not your
> half-baked vision. 
Um, ever hear of 'compromise'?? All I'm saying is let people use what
currently works until we can get an open-source solution. Ndiswrapper's
existence is not stopping you (or anyone else) from pestering manufacturers
for spec's and writing drivers. I look at ndiswrapper as a stop-gap solution.
Hey, even Linus himself has said 'better a sub-optimal solution than no solution'.


> If you want to create some bastardized version and are
> willing to commit dollars and effort to maintaining the code needed to do
> so, feel free.
> 
> Regards,
> Sean
> 
> 
> 


I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
