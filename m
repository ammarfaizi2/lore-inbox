Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263260AbTCNE0J>; Thu, 13 Mar 2003 23:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263261AbTCNE0J>; Thu, 13 Mar 2003 23:26:09 -0500
Received: from air-2.osdl.org ([65.172.181.6]:55948 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263260AbTCNE0I>;
	Thu, 13 Mar 2003 23:26:08 -0500
Message-ID: <33207.4.64.238.61.1047616615.squirrel@www.osdl.org>
Date: Thu, 13 Mar 2003 20:36:55 -0800 (PST)
Subject: Re: perfctr-2.5.0 released
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <jamagallon@able.es>
In-Reply-To: <20030314012502.GA20357@werewolf.able.es>
References: <200303110002.h2B02Uxa025848@harpo.it.uu.se>
        <20030314012502.GA20357@werewolf.able.es>
X-Priority: 3
Importance: Normal
Cc: <mikpe@user.it.uu.se>, <perfctr-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On 03.11, Mikael Pettersson wrote:
>> Version 2.5.0 of perfctr, the Linux/x86 performance
>> monitoring counters driver, is now available at the usual
>> place: http://www.csd.uu.se/~mikpe/linux/perfctr/
>>
>
> Perhaps this has been asked for a million times, but I'm new to
> perfctrs...
> Is there any tool available to profile a program based on this ?
> I have seen perfex, but that gives total counts. I would like something like
> gprof... We are now optimizing some software and I would like to make my
> colleagues leave Windows (they use Intel's VTune) and go to Linux.
> Or at least compare the same kind of things between VTune on win and
> 'something' in Linux that also uses the counters. They don't seem to trust
> gprof. And, looking at the results, I'm beginning to untrust VTune...

I hope that Mikael knows of some native Linux tools for this.
However, Intel did announce Vtune for Linux recently (might still be
in beta test), and there was a SuSE patch for it posted at
kernelnewbies.org also.  See:

http://www.linuxhardware.org/comments.pl?sid=364&cid=530
http://www.linuxhardware.org/articles/03/01/17/1633229.shtml
http://kernelnewbies.org/kernels/SuSE81/SOURCES/patches.i386/50_vtune-ia32
  (warning: this is for 2.4.19)

or google for "+vtune +linux".

~Randy



