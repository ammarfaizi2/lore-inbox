Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264113AbRFFTdf>; Wed, 6 Jun 2001 15:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264112AbRFFTdZ>; Wed, 6 Jun 2001 15:33:25 -0400
Received: from paperboy.noris.net ([62.128.1.27]:11447 "EHLO mail2.noris.net")
	by vger.kernel.org with ESMTP id <S264110AbRFFTdP>;
	Wed, 6 Jun 2001 15:33:15 -0400
Mime-Version: 1.0
Message-Id: <p0510030eb74434e454bf@[192.109.102.42]>
In-Reply-To: <B74421C0.F6F7%bootc@worldnet.fr>
In-Reply-To: <B74421C0.F6F7%bootc@worldnet.fr>
Date: Wed, 6 Jun 2001 21:32:53 +0200
To: Chris Boot <bootc@worldnet.fr>,
        Linux Kernel <linux-kernel@vger.kernel.org>
From: Matthias Urlichs <smurf@noris.de>
Subject: Re: temperature standard - global config option?
Cc: "David N. Welton" <davidw@apache.org>, Pavel Machek <pavel@suse.cz>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:06 +0200 2001-06-06, Chris Boot wrote:
>I'm sorry, by I don't feel like adding 273 to every number I get just to
>find the temperature of something.

That's much easier than subtracting 32 and multiplying by 5/9.  ;-)

>  What I would do is give configuration
>options to choose the default (Celsius/centigrade, Kelvin, or [shudder]
>Fahrenheit)

The kernel output should not be configurable. You have tools for 
printing the information; they can do the calculation for you.

Personally I'd like to see cK (centi-Kelvin).
-- 
Matthias Urlichs
