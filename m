Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262078AbRE1HAw>; Mon, 28 May 2001 03:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbRE1HAn>; Mon, 28 May 2001 03:00:43 -0400
Received: from [62.231.2.151] ([62.231.2.151]:49417 "EHLO mail.ixcelerator.com")
	by vger.kernel.org with ESMTP id <S262078AbRE1HAa>;
	Mon, 28 May 2001 03:00:30 -0400
Date: Mon, 28 May 2001 11:01:09 +0400
Message-Id: <200105280701.f4S719d03797@morgoth.ixcelerator.com>
From: green@linuxhacker.ru
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac1 hard disk corruption... acpi responsible?
In-Reply-To: <E1544AG-00026i-00@the-village.bc.nu>
X-Newsgroups: linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.4 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E1544AG-00026i-00@the-village.bc.nu> you wrote:
> Bad idea. The kernel ACPI is not the most debugged, the ACPI in many BIOSes
> is complete garbage and there isnt a lot you can do to debug them either.
> APM is a definite better choice, at least in the shorter term
Too bad, we cannot get much of APM in SMP, only power-off if one gets lucky.

Bye,
    Oleg
