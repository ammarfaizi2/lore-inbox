Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbTFIS2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 14:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTFIS2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 14:28:52 -0400
Received: from wmail.atlantic.net ([209.208.0.84]:30343 "HELO
	wmail.atlantic.net") by vger.kernel.org with SMTP id S264235AbTFIS2v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 14:28:51 -0400
Message-ID: <3EE4D80A.2050402@techsource.com>
Date: Mon, 09 Jun 2003 14:55:06 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding standards.  (Was: Re: [PATCH] [2.5] Non-blocking write
 can block)
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk> <20030604065336.A7755@infradead.org> <3EDE0E85.7090601@techsource.com> <20030607001202.GB14475@kroah.com> <3EE4B4C3.80902@techsource.com> <20030609163959.GA13811@wohnheim.fh-wedel.de> <Pine.LNX.4.55.0306091001270.3614@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Davide Libenzi wrote:
> On Mon, 9 Jun 2003, [iso-8859-1] J?rn Engel wrote:
> 
> 
>>In the case of the kernel, there is quite a bit of horrible coding
>>style.  But a working device driver for some hardware is always better
>>that no working device driver for some hardware, and if enforcing the
>>coding style more results is scaring away some driver writers, the
>>style clearly loses.
> 
> 
> There's no such a thing as "horrible coding style", since coding style is
> strictly personal. Whoever try to convince you that one style is better
> than another one is simply plain wrong. Every reason they will give you to
> justify one style can be wiped with other opposite reasons. The only
> horrible coding style is to not respect coding standards when you work
> inside a project. This is a form of respect for other people working
> inside the project itself, give the project code a more professional
> look and lower the fatigue of reading the project code. Jumping from 24
> different coding styles does not usually help this. I do not believe
> professional developers can be scared by a coding style, if this is the
> coding style adopted by the project where they have to work in.

Oh, yes, there is most certainly "horrible coding style".  When I was in 
college, I met one CS student after another who really just did not 
belong in CS, and you should have seen the code they wrote.

Imagine a 200 line program which is ALL inside of main().  There is no 
indenting.  Lines of code are broken in random places.  Blank lines are 
inserted randomly.  The variable names chosen are a, b, c, d, e, etc. 
It's impossible to tell which '{' is associated with which '}'.

It's been a while.  I can't remember all of the violations of reason and 
sanity I saw.  I pity the grad students who were faced with grading 
these monstrosities.

