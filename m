Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263334AbTCNOvD>; Fri, 14 Mar 2003 09:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263336AbTCNOvD>; Fri, 14 Mar 2003 09:51:03 -0500
Received: from ms-smtp-01.southeast.rr.com ([24.93.67.82]:6288 "EHLO
	ms-smtp-01.southeast.rr.com") by vger.kernel.org with ESMTP
	id <S263334AbTCNOvD>; Fri, 14 Mar 2003 09:51:03 -0500
Message-ID: <3E71EEBA.2040800@nc.rr.com>
Date: Fri, 14 Mar 2003 10:01:14 -0500
From: William Cohen <wcohen@nc.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Mikael Pettersson <mikpe@user.it.uu.se>,
       perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Perfctr-devel] Re: perfctr-2.5.0 released
References: <200303110002.h2B02Uxa025848@harpo.it.uu.se> <20030314012502.GA20357@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might also look at OProfile (http://oprofile.sourceforge.net/). 
There is an option in the oprofpp command to dump data OProfile collects 
in gprof format.

-Will

J.A. Magallon wrote:
> 
> On 03.11, Mikael Pettersson wrote:
> 
>> Version 2.5.0 of perfctr, the Linux/x86 performance
>> monitoring counters driver, is now available at the usual
>> place: http://www.csd.uu.se/~mikpe/linux/perfctr/
>>
> 
> Perhaps this has been asked for a million times, but I'm new to perfctrs...
> Is there any tool available to profile a program based on this ?
> I have seen perfex, but that gives total counts. I would like something
> like gprof... We are now optimizing some software and I would like to
> make my colleagues leave Windows (they use Intel's VTune) and go to
> Linux.
> Or at least compare the same kind of things between VTune on win and
> 'something' in Linux that also uses the counters. They don't seem to
> trust gprof. And, looking at the results, I'm beginning to untrust
> VTune...
> 
> TIA
> 


