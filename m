Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWCEPV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWCEPV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 10:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWCEPV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 10:21:26 -0500
Received: from smtp04.ya.com ([62.151.11.162]:52417 "EHLO smtpauth.ya.com")
	by vger.kernel.org with ESMTP id S932093AbWCEPV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 10:21:26 -0500
Message-ID: <440B01E1.8080102@ya.com>
Date: Sun, 05 Mar 2006 16:21:05 +0100
From: =?ISO-8859-1?Q?Ra=FAl_Baena?= <raul_baena@ya.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: es-es, es
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Doubt about scheduler
References: <4407584A.60301@ya.com> <35fb2e590603032233i7302162do553ba61674cc8e50@mail.gmail.com> <440AE3F3.3090404@ya.com> <440AE7E3.4060500@yahoo.com.au>
In-Reply-To: <440AE7E3.4060500@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I could to write the reason in my university job. (In Spain we have 
>> to make a final degree job, and mine is about modules in linux (I 
>> chose this), I would like to show information of the new scheduler, a 
>> scheduler monitor, and these fields are indispensable for me)
>
>
> If your task is about modules in Linux, then I don't see how that
> involves the scheduler at all?
>
> On the other hand, if you want a scheduler monitor then I can't see
> why it would be appropriate to implement as a module (we have schedstats,
> which you can read from a userspace program or daemon).
>
> Nick
>
Thank you very much Nick.

My task is free, I can do everything that I want that involves modules, 
I thought that to make the module about the new O(k) scheduler would be 
a good idea. I think that it´s not enough for me schedstats, because I 
want to make a visual scheduler, I mean, using GTK+ , a module and 
something else to make a visual scheduler monitor, how the tasks move 
between "active" and "expired", where the task are in prio_array with 
the bitmap fields...this module isn´t usefull, only in a didactic way. 
This is the reason because I have to make a module althought ( according 
with your recomendations, recomendations of a person who knows 
infinitely much than me) probably would be better to make another thing.

At any rate, I will search "schedstats" references, in case it was usefull.

Thank all of you very much again , with your help I hope to be able to 
make a good final degree job.
