Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSGAXmQ>; Mon, 1 Jul 2002 19:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSGAXmP>; Mon, 1 Jul 2002 19:42:15 -0400
Received: from jalon.able.es ([212.97.163.2]:58803 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316580AbSGAXmP>;
	Mon, 1 Jul 2002 19:42:15 -0400
Date: Tue, 2 Jul 2002 01:44:32 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] O(1) scheduler in 2.4
Message-ID: <20020701234432.GC1697@werewolf.able.es>
References: <Pine.LNX.3.96.1020701134937.23820A-100000@gatekeeper.tmr.com> <20020701181228.GF20920@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020701181228.GF20920@opus.bloom.county>; from trini@kernel.crashing.org on Mon, Jul 01, 2002 at 20:12:28 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.01 Tom Rini wrote:
>On Mon, Jul 01, 2002 at 01:52:54PM -0400, Bill Davidsen wrote:
>
>> What's the issue?
>
>a) We're at 2.4.19-rc1 right now.  It would be horribly
>counterproductive to put O(1) in right now.

.20-pre1 would be a good start, but my hope is that this reserved for
the vm updates from -aa ;).

>b) 2.4 is the _stable_ tree.  If every big change in 2.5 got back ported
>to 2.4, it'd be just like 2.5 :)

So you want to wait till 2.6.40 to be able to use a O1 scheduler on a
kernel that does not eat up your drives ? (say, next year by this same month...)

>c) I also suspect that it hasn't been as widley tested on !x86 as the
>stuff currently in 2.4.  And again, 2.4 is the stable tree.
>

I know it is not a priority for 2.4, but say it wil never happen...

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc1-jam1, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.7mdk)
