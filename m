Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUH0SJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUH0SJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266835AbUH0SJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:09:27 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:22789 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266833AbUH0SJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:09:20 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Kenneth Lavrsen <kenneth@lavrsen.dk>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
Date: Fri, 27 Aug 2004 21:08:38 +0300
User-Agent: KMail/1.5.4
References: <6.1.2.0.2.20040827171755.01c1f328@inet.uni2.dk>
In-Reply-To: <6.1.2.0.2.20040827171755.01c1f328@inet.uni2.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408272108.38811.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 August 2004 19:26, Kenneth Lavrsen wrote:
> And now the latest step of modifying the code so that it is useless like
> removing the hook for pwcx. I have been using pwc/pwcx for years now and
> the driver has been working well. Better than so many other USB based
> devices I have tried and rejected.
> The binary pwcx module has been accepted for years. And now fanatism has
> taken over and suddenly the pwcx module is no longer pure. And it does not
> seem like Greg spent even one second thinking about the 10000s of people
> that have invested in the quite expensive (but much better than anything
> else) Logitech and Philips cameras - knowing that it was supported by
> Linux. He just destroyed the driver without a wink.
> Did he think: "To hell with all the Linux users with a USB camera - I don't
> care about other people - I care only about my own principles"?
>
> Kernel developers sits with the power to reject incoming patches. Such
> priviledge should be handled with respect. Not only to the individual
> contributors - but also to the millions of Linux users that depends on
> their behavour. What I have seen is in my eyes abuse of this power.
> I would never remove a feature from Motion without a proper debate with my
> users. Being a maintainer of an OSS project is a priviledge - not a right.

Nobody and nothing prevents you from patching that druver back in.
You dont like the fact that Linus' tree does not contain it anymore.
Well. It's *Linus'* tree.

You are completely free to either maintain out-of-tree patch or
to fork a tree.

This is the freedom given to you by GPL.
--
vda

