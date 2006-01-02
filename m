Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWABX6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWABX6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 18:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWABX6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 18:58:53 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:21997 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751136AbWABX6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 18:58:51 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: gcoady@gmail.com, Arjan van de Ven <arjan@infradead.org>,
       Antonio Vargas <windenntw@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, mingo@elte.hu, tim@physik3.uni-rostock.de,
       torvalds@osdl.org, davej@redhat.com, linux-kernel@vger.kernel.org,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Date: Tue, 03 Jan 2006 10:58:56 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <8ffjr1tbc32odbpcfrufitr4tp08glps7v@4ax.com>
References: <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <20060102134228.GC17398@stusta.de> <20060102102824.4c7ff9ad.akpm@osdl.org> <1136227746.2936.46.camel@laptopd505.fenrus.org> <sq7jr1l1ffgdc5ra26ra6n2ota7osj9c2q@4ax.com> <69304d110601021403o59a10c77i3d9ef8dc046e27bd@mail.gmail.com> <1136242584.2839.1.camel@laptopd505.fenrus.org> <micjr1lipg2puqbtsocicc37vtfcjbu1jk@4ax.com> <1136246274.8570.24.camel@localhost.localdomain>
In-Reply-To: <1136246274.8570.24.camel@localhost.localdomain>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Jan 2006 23:57:53 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>On Maw, 2006-01-03 at 10:10 +1100, Grant Coady wrote:
>> >+There appears to be a common misperception that gcc has a magic "make me
>> >+faster" ricing option called "inline". While the use of inlines can be
>>           ^^^^^^--?? not sure what this is
>
>American car kiddy slang. Not appropriate for internationally read
>documentation. Think "go faster stripes" etc.

"go faster stripes" works for me :o)  (from the land down under)

Cheers,
Grant.
