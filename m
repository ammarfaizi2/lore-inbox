Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262830AbVEHJsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbVEHJsx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 05:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVEHJsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 05:48:53 -0400
Received: from colino.net ([213.41.131.56]:51960 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262830AbVEHJsv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 05:48:51 -0400
Date: Sun, 8 May 2005 11:48:39 +0200
From: Colin Leroy <colin@colino.net>
To: =?ISO-8859-15?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Cc: linux-kernel@vger.kernel.org, debian-powerpc@lists.debian.org,
       Roman Zippel <zippel@linux-m68k.org>, Brad Boyer <flar@allandria.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, rtbrito@ig.com.br
Subject: Re: Oops and BUG's with hfsplus module
Message-ID: <20050508114839.44ed10dc@jack.colino.net>
In-Reply-To: <20050507235454.GA16058@ime.usp.br>
References: <20050507235454.GA16058@ime.usp.br>
X-Mailer: Sylpheed-Claws 1.9.6cvs36 (GTK+ 2.6.4; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 May 2005 at 20h05, Rogério Brito wrote:

Hi, 

> The drive is an IDE HD in a firewire enclosure and it seems to work
> well for the first few operations. Then, the kernel generates loads
> of messages, when I try to do some simple things.
> 
> Yesterday, I got a quite scary ooops and, today, after trying a newer
> kernel, I got many messages in my dmesg logs.

I've had problems mounting my iPod with Firewire, whereas USB works ok.
Do you have the ability to test an hfsplus filesystem over usb-storage?
Maybe the problem comes from sbp2.

Also, can you try with 2.6.12-rc4?

-- 
Colin
