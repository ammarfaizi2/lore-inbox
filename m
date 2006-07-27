Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWG0LLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWG0LLS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 07:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWG0LLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 07:11:18 -0400
Received: from vsmtp4.tin.it ([212.216.176.224]:51199 "EHLO vsmtp4.tin.it")
	by vger.kernel.org with ESMTP id S1751243AbWG0LLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 07:11:16 -0400
Message-ID: <2870.192.167.206.189.1153998447.squirrel@darkstar.linuxpratico.net>
In-Reply-To: <20060727100446.GK23701@stusta.de>
References: <20060726134326.GD23701@stusta.de>
    <20060726142854.GM32243@opteron.random>
    <20060726145019.GF23701@stusta.de>
    <20060726160604.GO32243@opteron.random>
    <20060726170236.GD31172@fieldses.org>
    <20060726172029.GS32243@opteron.random>
    <20060726205022.GI23701@stusta.de>
    <20060726211741.GU32243@opteron.random>
    <20060727065603.GJ23701@stusta.de>
    <4284.192.167.206.189.1153989192.squirrel@darkstar.linuxpratico.net>
    <20060727100446.GK23701@stusta.de>
Date: Thu, 27 Jul 2006 13:07:27 +0200 (CEST)
Subject: Re: the ' 'official' point of view' expressed by kernelnewbies.org 
     regarding reiser4 inclusion
From: "Luigi Genoni" <genoni@sns.it>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Luigi Genoni" <genoni@sns.it>, andrea@cpushare.com,
       "J. Bruce Fields" <bfields@fieldses.org>,
       "Hans Reiser" <reiser@namesys.com>,
       "Nikita Danilov" <nikita@clusterfs.com>,
       "Rene Rebe" <rene@exactcode.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still I am missing something.

I am not interested in discussing about 1:5 ora 5:1 or so on.
I am not even interested if reiser4 users are 35 or 35000.
But if some people felt they need reiser4 to get their work done, that means
something. The numbers and the datum per se are meaningless.

Anyway you have a datum.
Some people need reiser4, period.

Why they need reiser4?
all of them are just playing with him to have a new game for their spare time?
I don't think so.
Some of them are using reiser4 because it is the best solution for their work?
this is a concrete possibility.

again... why that?
Because the other FSs are not suitable for certain work?
Because the other FSs are suitable, but reiser4 offers better results?
Because even reiser4 is not complitelly suitable for some kind of work, but
the other FSs are a worser solution?

I don't think most reiser4 users decided to give it a try just to enjoy
their time making tests just because they are curious.

that does not mean reiser4 should be merged into linux kernel because of
this. On the other side you can agree reiser4 has its place, because there
are users who need it. What we would need to understand, sine ira nec
studio, is where this place is.

On Thu, July 27, 2006 12:04, Adrian Bunk wrote:
> On Thu, Jul 27, 2006 at 10:33:12AM +0200, Luigi Genoni wrote:
>
>>
>>
>>
>> On Thu, July 27, 2006 08:56, Adrian Bunk wrote:
>>
>>>
>>>> Said that pretending that KLive data has absolutely no significance
>>>> at all and that you can't draw any conclusion at all from it, to me
>>>> seems as wrong as pretending it to perfect.
>>>
>>> Possibly wrong conclusions about the general market share based on data
>>>  not having the quality for being the basis of such statements are
>>> worse than having no data.
>>
>> Am I missing something, or it is not marketing what we are talking about?
>>  please I do not understand your point.
>>
>> For what I understand... I was not supposing reiser4 users to be so
>> mutch, but this is very usefull because this means that there are more
>> possibilities to test the code well and to fix bugs... ...
>>
>
> I'm sorry for saying it that directly, and this is not meant against you
> personally:
>
>
> Your statement is a good example why this data is worse than having no
> data.
>
> As I already said in this thread:
>
>
> <--  snip  -->
>
>
> You are able to say that based on klive data, reiser4 has at least
> 35 users in the world.
>
>
> But you can not tell based on klive data whether the ratio of
> reiser4:ext3 users in the world is more like 1:5, 1:500 or 1:50000.
>
>
> <--  snip  -->
>
>
> I can't prove that the 1:5 ratio is wrong, but the point is that
> claiming a 1:5 ratio was true based on the klive data is not better than
> claiming it based on no data. But claiming it based on the klive data is
> worse since people like you are getting the wrong impression it was based on
> data that would have the quality for supporting such a statement.
>
> The data simply has not the quality for such a statement.
> Please read my two examples in [1] if you want to get an impression why
> such problems can occur.
>
> cu Adrian
>
>
> [1] http://lkml.org/lkml/2006/7/26/203
>
>
> --
>
>
> "Is there not promise of rain?" Ling Tan asked suddenly out
> of the darkness. There had been need of rain for many days. "Only a promise,"
> Lao Er said.
> Pearl S. Buck - Dragon Seed
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>

