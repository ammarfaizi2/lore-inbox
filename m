Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282272AbRKWWrC>; Fri, 23 Nov 2001 17:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282275AbRKWWqx>; Fri, 23 Nov 2001 17:46:53 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:9856 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S282272AbRKWWqn>;
	Fri, 23 Nov 2001 17:46:43 -0500
Message-ID: <3BFED1D0.49801F19@pobox.com>
Date: Fri, 23 Nov 2001 14:46:40 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sunrpc woes with tux2 in 2.4.15-pre8,9
In-Reply-To: <Pine.LNX.4.33.0111231257070.5254-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> following Trond's suggestions i reverted the dec_and_lock hacks from the
> TUX patch. Could you try the latest 2.4.15-B2 patch:
>
>         http://redhat.com/~mingo/TUX-patches/tux2-full-2.4.15-pre9-B2.bz2
>
> (it will apply to 2.4.15-final just as well) Does this solve the symbol
> export problem?

hehe - I just lost some time to the greased turkey,
aka brown paper bag release. Even lilo was unable
to proceed.

(Thank you Patrick Volkerding, the slackware boot
disks saved me again!)

I'll confirm the latest tux2 works when I compile the
first available 2.4.15+patch -

cu

jjs

