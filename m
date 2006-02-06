Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWBFRBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWBFRBz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 12:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWBFRBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 12:01:54 -0500
Received: from spare.moebius.com.br ([200.184.42.83]:55268 "EHLO
	spare.moebius.com.br") by vger.kernel.org with ESMTP
	id S932228AbWBFRBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 12:01:53 -0500
Message-ID: <43E7816E.4060905@moebius.com.br>
Date: Mon, 06 Feb 2006 15:03:42 -0200
From: Pedro Alves <pedro@moebius.com.br>
Organization: Moebius Tecnologia em =?ISO-8859-1?Q?Inform=E1tica_Ltda?=
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Chow <davidchow@shaolinmicro.com>
CC: Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux drivers management
References: <43E71AD7.5070600@shaolinmicro.com> <yq0d5i0ol4i.fsf@jaguar.mkp.net> <43E77EEA.7040908@shaolinmicro.com>
In-Reply-To: <43E77EEA.7040908@shaolinmicro.com>
Content-Type: multipart/mixed;
 boundary="------------080202000504000804020001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080202000504000804020001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David,

   You got my vote..... I make simple hardware to improve availability 
of operational systems and i just
can't go to build a native driver because i could not find a kit that 
works.... now i use a perl script to
acomplish this mission... it works greate but is not beaulty as i like 
it to be.... Time is money.....

  Pedro Alves

David Chow wrote:

>
>> David> separate Linux drivers and the the main kernel, and manage
>> David> drivers using a package management system that only manages
>> David> kernel drivers and modules? If this can be done, the kernel
>> David> maintenance can be simple, and will end-up with a more stable
>> David> (less frequent changed) kernel API for drivers, also make every
>> David> developers of drivers happy.
>>
>> David> Would like to see that happens .
>>
>> Simple answer: no
>>
>> Maybe someone is working on it, but it's highly unlikely to be
>> anything but a waste of that person's time.
>>
>> This is a classic question, by seperating out the drivers you make it
>> so much harder for all developers to propagate changes into all pieces
>> of the tree.
>
> I write drivers, never need to change kernel if the kernel API is 
> mature enough to provide the need of a module developer needs. There 
> is no reason to make changes to the kernel source, only needed because 
> the original kernel code is crap or the API designed without proper 
> software/system architectural design work effort. Each Linux kernel 
> version go through a lengthy beta release cycle (e.g. 2.3, 2.5, 2.7), 
> this shouldn't happen and idea collection should be enough through 
> this large Linux community.
>
> If our time is to focus on kernel's kernel, writing good documentation 
> about a stable kernel API, it will benefit many developers to write 
> drivers to Linux . It is too difficult to learn, this is a main reason 
> why Linux is lack of support from manufacturer drivers, not because 
> they don't like Linux and no market, it is because this has created 
> high entry barrier for them.
>
> I've been working on Linux modules for many years, training my 
> engineers, talking to developers, hw manufacturers .. believe it or 
> not, this is the main reason. They all ask for a DDK for Linux that 
> can make drivers easily for their product.
>
> I think I am in a different position like you guys, I've been work 
> with Linux from programmer level to Linux promotion . My goal is not 
> just focus on Linux technical or programming, I would like to promote 
> this operating system to not just for programmers, but also 
> non-technical end-users . Writing C code to me is just bits of task of 
> some process.  You are too much focus on programming without 
> considering the market situation.
>
> There is no right or wrong for this question, but my original question 
> is to listen thoughts and to hear the goal of people in the list. And 
> of course, I would really like to see you people look into the way to 
> facilitate more people gets a path with ease to Linux drivers 
> development. User driver installation without the need to know about 
> kernel sources, gcc, make etc....  "Because I am a dummy, I want to 
> plug-in my device, put in the driver disc and hope it works!"
>
> regards,
> David Chow
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


--------------080202000504000804020001
Content-Type: text/x-vcard; charset=utf-8;
 name="pedro.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pedro.vcf"

begin:vcard
fn:Pedro Alves
n:Alves;Pedro
org:Moebius Tecnologia em Informatica Ltda
adr:;;Rua Jardim Botanico 674 sala 507;Rio de janeiro;RJ;22461000;Brasil
email;internet:pedro@moebius.com.br
title:Diretor de Marketing
tel;work:21 2294-3772
tel;fax:21 2294-2794
tel;home:21 8762-1264
tel;cell:21 8762-1264
x-mozilla-html:TRUE
url:http://www.moebius.com.br
version:2.1
end:vcard


--------------080202000504000804020001--
