Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267007AbSL3Qyl>; Mon, 30 Dec 2002 11:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267008AbSL3Qyl>; Mon, 30 Dec 2002 11:54:41 -0500
Received: from franka.aracnet.com ([216.99.193.44]:29392 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267007AbSL3Qyk>; Mon, 30 Dec 2002 11:54:40 -0500
Date: Mon, 30 Dec 2002 09:02:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: kernel-janitor-discuss@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Current unclaimed 2.5 bugs on bugme.osdl.org
Message-ID: <299610000.1041267777@titus>
In-Reply-To: <1041255152.544.14.camel@zion.wanadoo.fr>
References: <129460000.1041214462@titus>
 <1041255152.544.14.camel@zion.wanadoo.fr>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> ID Sev Owner State Result Summary
>> 44 blo khoa@us.ibm.com OPEN radeonfb does not compile at all - seems
>> incomplete? or w...
>
> Beeing worked on by James Simmons and myself. Working version in the PPC
> tree, will be part of next round of fbdev updates
>
>> 69 nor mbligh@aracnet.com OPEN Framebuffer bug
>> 72 nor khoa@us.ibm.com OPEN Framebuffer scrolls at the wrong times/places
>> 79 nor khoa@us.ibm.com OPEN Framebuffer scrolling problem
>
> I've seen at least some of these discussed on the linux-fbdev mailing
> list, though I can't talk for the maintainer, I beleive they are beeing
> worked on.

OK, trouble is I need someone with a bugzilla account to assign these to.
I emailed James, if he doesn't want it, would you be willing to maintain
that subsection in bugzilla?

>> 117 nor mbligh@aracnet.com OPEN build failure: arch/ppc/kernel/process.c
>
> Works in current ppc bk tree, probably waiting for next round of merges
> by Paul Mackerras to Linus.

According to DaveJ, this should be fixed in 51 ... anyone able to test?

M.

