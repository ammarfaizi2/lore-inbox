Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130208AbRAYUaX>; Thu, 25 Jan 2001 15:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131811AbRAYUaN>; Thu, 25 Jan 2001 15:30:13 -0500
Received: from hs-gk.cyberbills.com ([216.35.157.254]:58121 "EHLO
	hs-mail.cyberbills.com") by vger.kernel.org with ESMTP
	id <S130208AbRAYUaG>; Thu, 25 Jan 2001 15:30:06 -0500
Date: Thu, 25 Jan 2001 12:29:59 -0800 (PST)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: Micah Gorrell <angelcode@myrealbox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 problems in 2.4.0
In-Reply-To: <003401c0870c$3362e390$9b2f4189@angelw2k>
Message-ID: <Pine.LNX.4.31ksi3.0101251224490.6238-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, Micah Gorrell wrote:

I have it too. Kernel spits a lot of "eepro100: wait_for_cmd_done timeout!"
and network doesn't work. 2.2 is fine. This behaviour is not persistent,
sometimes the eepro100 module is loaded without such an error and works fine
then.

The eepro100 in question is the built-in one based on 82559 chip.


> I have doing some testing with kernel 2.4 and I have had constant
> problems
> with the eepro100 driver.  Under 2.2 it works perfectly but under 2.4 I
> am
> unable to use more than one card in a server and when I do use one card
> I
> get errors stating that eth0 reports no recources.  Has anyone else
> seen
> this kind of problem?
>
> Micah
> ___
> The irony is that Bill Gates claims to be making a stable operating
> system
> and Linus Torvalds claims to be trying to take over the world
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>
>

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8890
Henderson, NV, 89014

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
