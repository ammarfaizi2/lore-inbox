Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWBKCQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWBKCQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 21:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWBKCQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 21:16:47 -0500
Received: from macferrin.com ([65.98.32.91]:50437 "EHLO macferrin.com")
	by vger.kernel.org with ESMTP id S932079AbWBKCQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 21:16:46 -0500
Message-ID: <43ED48AD.6060106@macferrin.com>
Date: Fri, 10 Feb 2006 19:15:09 -0700
From: Ken MacFerrin <lists@macferrin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Thunderbird/1.0.7 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Dave Spring <dspring@acm.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
References: <43E0FC55.6080503@acm.org> <43EBD67E.9020308@acm.org> <200602100013.15276.s0348365@sms.ed.ac.uk>
In-Reply-To: <200602100013.15276.s0348365@sms.ed.ac.uk>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Thursday 09 February 2006 23:55, Dave Spring wrote:
> 
>>Just for closure's sake:
>> This turned out to be a hardware problem.
>>Memtest86+ http://www.memtest.org/ found an intermittent and
>>pattern-sensitive memory error,
>>and only appearing at one or two random locations within the 256M module.
>>Replacing the dodgy RAM module did the trick.
> 
> 
> Thanks Dave. Any update on your problem Ken? I'm keen to hear whether you had 
> crashes without the NVIDIA driver loaded.
> 

Sorry, I got called out of town last weekend so I didn't get a chance to 
try this out yet..
-Ken
