Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWGMNtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWGMNtW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWGMNtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:49:21 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:55438 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751387AbWGMNtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:49:21 -0400
Message-ID: <44B64F57.4060407@cmu.edu>
Date: Thu, 13 Jul 2006 09:49:11 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
References: <44B5CE77.9010103@cmu.edu> <44B604C8.90607@goop.org>
In-Reply-To: <44B604C8.90607@goop.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not seeing any problems at all, though I am not seeing anything
happen :)

If I Fn+suspend... nothing happens ... if i Fn+hibernate ... nothing happens

What patches did you use?

Thanks!
George


Jeremy Fitzhardinge wrote:
> George Nychis wrote:
>> I was wondering if anyone has gotten suspend or hibernate to work on a
>> Thinkpad x60s?  I have googled around for support in the kernel and
>> haven't been able to find anyone fully successful with it.
>>   
> I have suspend/resume working fine on an X60.  Needs some patches to
> make it work though.  What problems are you seeing?
> 
>    J
> 
