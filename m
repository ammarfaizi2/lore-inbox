Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUBTOAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 09:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbUBTOA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 09:00:29 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:45964 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261205AbUBTN6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 08:58:39 -0500
Date: Fri, 20 Feb 2004 21:58:30 +0800
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>,
       "Nick Bartos" <spam99@2thebatcave.com>
Subject: Re: recommended "stable" compiler?
Cc: "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>
References: <58930.192.168.1.12.1077278393.squirrel@mail.2thebatcave.com> <1077283178.798.2.camel@teapot.felipe-alfaro.com>
From: "Michael Frank" <mhf@linuxmail.org>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr3n83soj4evsfm@smtp.pacific.net.th>
In-Reply-To: <1077283178.798.2.camel@teapot.felipe-alfaro.com>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004 14:19:39 +0100, Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:

> On Fri, 2004-02-20 at 12:59, Nick Bartos wrote:
>> What is the recommended stable compiler for compiling the latest 2.4.x
>> kernel?
>
> I'm no kernel guru, but I have been compiling 2.5/2.6 kernels for a long
> time with gcc 3.3 with no problems at all. I had problems with gcc 3.2
> in the past, miscompiling the ymfpci driver.
>

I am linux newbie, but have done 100's of kernel compiles the past 2 years.

AFAIK, 2.95.3 is still the official compiler and still supported.

2.95.3 without framepointers compiling kernels for 686 has never failed me
with 2.4 and 2.6 and I still use it exclusively for kernels.

3.2.2 made me lots of trouble with kernels - crashing within minutes.

Using RH 3.2.5 and Gentoo 3.2.3 for other compiles (whole system except kernel
in case of gentoo). No problems seen.

Have not tried 3.3 but by what I have read it is OK.

In any case keep your trusted old workhorse 2.95 around when trying something new...

Regards
Michael
