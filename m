Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbTEKAZW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 20:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbTEKAZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 20:25:22 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:38865 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S264538AbTEKAZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 20:25:21 -0400
Message-ID: <3EBD9B1E.6050304@blue-labs.org>
Date: Sat, 10 May 2003 20:36:46 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030509
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David van Hoose <davidvh@cox.net>
CC: Norbert Wolff <norbert_wolff@t-online.de>, Andy Pfiffer <andyp@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] devfs [was Re: ALSA busted in 2.5.69]
References: <fa.j6n4o02.sl813a@ifi.uio.no>	<fa.juutvqv.1inovpj@ifi.uio.no>	<3EBBF00D.8040108@hotmail.com>	<1052507530.15922.37.camel@andyp.pdx.osdl.net> <20030510080440.3446cc96.norbert_wolff@t-online.de> <3EBD8941.7070403@blue-labs.org> <3EBD9560.8060504@cox.net>
In-Reply-To: <3EBD9560.8060504@cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've used devfs for years.  A few people here and there gripe about it, 
my only gripe about it are drivers that don't [haven't yet] been updated 
to use it.  In 2.5 those are rare.  As to 2.4 vs 2.5, there aren't too 
many user visible changes and I think most of the new things for devfs 
(user visible) in 2.5 are also in 2.4.

My vote: devfs is _great_

David

David van Hoose wrote:

> David Ford wrote:
>
>> Shrug :)
>>
>> I use devfs, all is magic.  All is [nearly always] correct.
>
>
> Are there any compatibility issues in 2.4 while using devfs under 2.5? 
> I'm looking into it, but I'd like to hear that there are no problems 
> before I jump into using it.
> I would love to hear comments from anyone using devfs. Good or bad.
>
> Thanks,
> David


