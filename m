Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWD1Jhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWD1Jhf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 05:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbWD1Jhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 05:37:35 -0400
Received: from host217-46-213-187.in-addr.btopenworld.com ([217.46.213.187]:8802
	"EHLO help.basilica.co.uk") by vger.kernel.org with ESMTP
	id S1030344AbWD1Jhe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 05:37:34 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Compiling C++ modules
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Fri, 28 Apr 2006 10:37:40 +0100
Message-ID: <8941BE5F6A42CC429DA3BC4189F9D4420A1396@bashdad01.hd.basilica.co.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compiling C++ modules
Thread-Index: AcZqpvmOuxhVsjxfQwu1ZnaW4zVoVgAACSTg
From: "Khushil Dep" <khushil.dep@help.basilica.co.uk>
To: "Avi Kivity" <avi@argo.co.il>, "Davi Arnaut" <davi.lkml@gmail.com>
Cc: "Willy Tarreau" <willy@w.ods.org>, "Denis Vlasenko" <vda@ilport.com.ua>,
       <dtor_core@ameritech.net>, "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have think about your own tag line mate. C is pure. A kernel should be
as pure as possible. Leave it alone folks - haven't we all been down
this road before? Why does everyone want to move higher and higher up
the ladder when it comes to languages? Does no one still love to code in
pure ASM any more or am I just stuck in the past? Leave complexity for
application programmers. System programmers should dream in binary and
talk ASM. :-)

-----------------------
Mr. W. A. Khushil Dep

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Avi Kivity
Sent: 28 April 2006 10:34
To: Davi Arnaut
Cc: Willy Tarreau; Denis Vlasenko; dtor_core@ameritech.net; Kyle
Moffett; Alan Cox; linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules

Davi Arnaut wrote:
>>
>> Mozilla is written in C++ ? I start to better understand where the
>> 160 MB bloat comes from...
>>     
>
> Evolution is written in C.
>   

FWIW, userspace is moving away from C as unproductive and unsafe. KDE is

of course C++, mozilla, openoffice are C++, and gnome is moving towards 
(of all things) C#.

GCC considered adopting a C++ subset. My impressions of the discussion 
was that (a) a majority of the developers would like that (b) RMS would 
never allow it (c) there were concerns about bootstrap on platforms 
where a C++ compiler was not available.

Kernels of other operating systems (Windows, AIX (?)) allow C++. And 
don't start about Windows crashing whenever you sneeze at it - it's so
1998.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick
to panic.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
