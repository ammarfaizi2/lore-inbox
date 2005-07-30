Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262781AbVG3AQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbVG3AQG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbVG3APy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:15:54 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:33444 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262823AbVG3APW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:15:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Xx1Omms0HR1g3OUUGQu3j/YOUwrp1MKfSi3BgELHN9zhelqaMHeL5MuMNtCaLlGtNb+leJgQqwl6/Zejt5YC3ZiZgpooBXwk84+gSa8yOAol50f9YgAbe0nV4nvIVCU3A9ScagjpK9ka2wIH61CzqmNQtGuwHJ0IFXlHUluYXac=
Message-ID: <42EAC686.5060604@gmail.com>
Date: Fri, 29 Jul 2005 20:15:02 -0400
From: Puneet Vyas <vyas.puneet@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i387 floating-point test program/benchmark
References: <200507291639_MC3-1-A5E6-856D@compuserve.com>
In-Reply-To: <200507291639_MC3-1-A5E6-856D@compuserve.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:

>/* fp.c: i387 benchmark/test program */
>  
>

[puneet@localhost C]$ cc FPUtest.c -o FPUtest

FPUtest.c: In function `main':

FPUtest.c:103: warning: passing arg 2 of `sched_setaffinity' makes 
integer from pointer without a cast

FPUtest.c:103: error: too few arguments to function `sched_setaffinity'


