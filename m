Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVL0QLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVL0QLy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 11:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVL0QLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 11:11:53 -0500
Received: from mtl.rackplans.net ([65.39.167.249]:40922 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S932244AbVL0QLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 11:11:53 -0500
Date: Tue, 27 Dec 2005 11:11:41 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: Nauman Tahir <nauman.tahir@gmail.com>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: ia_64_bit Performance difference
In-Reply-To: <f0309ff0512270010g39d42f83rf9da794f455854a5@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0512271105130.2104@innerfire.net>
References: <f0309ff0512262318r6d06292u7b151f2608b286cf@mail.gmail.com> 
 <1135669831.2926.11.camel@laptopd505.fenrus.org>
 <f0309ff0512270010g39d42f83rf9da794f455854a5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2005, Nauman Tahir wrote:
> On 12/27/05, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Tue, 2005-12-27 at 12:18 +0500, Nauman Tahir wrote:
> > > Hi all,
> > > I have written a block device driver. Driver includes the
> > > implementation of write back cache policy. Purpose of the driver is
> > > not an issue. The problem I am facing is the considerable difference
> > > of performance when I run same driver on 32 and 64 BIT OS. I am
> > > testing the driver on 64 Bit Machine and run the same driver on both
> > > (32 and 64 Bit) OS. On 32 Bit, IO rate is almost double then on 64 Bit
> > > OS. ( i wish it could have been opposite :( )
> >
> > you forgot to post the URL to your source code...
> 
> I did NOT FORGET to post the URL of my code as I mentioned I am
> interested in general
> areas of the kernel to look for. Like is there any problem related to
> 64 bit specific kernel compilation etc...
> 
> You should ask for my system configurations. As far as the code is
> concered there is not any architecture specific issue I guess in that.
> I have used threads of MD as my generic thread library and have used
> calculations based on unsigned long.
> 
> Kernel Version:
> I am using is 2.6.9 and onwards.
> 
> Machine configuration is :
> HP Prolient DL 145 (Dual Opteron 244 Processors with 14GB RAM)

Opteron is not ia_64 it's X86_64.  ia_64 is Itanuim.

	Gerhard




--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
