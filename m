Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262344AbTCMNYQ>; Thu, 13 Mar 2003 08:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262332AbTCMNYQ>; Thu, 13 Mar 2003 08:24:16 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:36881
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262344AbTCMNYO>; Thu, 13 Mar 2003 08:24:14 -0500
Date: Thu, 13 Mar 2003 08:31:51 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrey Panin <pazke@orbita1.ru>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] irq handling code consolidation (common part)
In-Reply-To: <20030313132148.GG1393@pazke>
Message-ID: <Pine.LNX.4.50.0303130830520.6957-100000@montezuma.mastecende.com>
References: <20030313132148.GG1393@pazke>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Mar 2003, Andrey Panin wrote:

> Hi all,
> 
> here I am bringing new set of irq handling consolidation patches :)
> 
> Attached patch (2.5.64) creates kernel/irq.c which contains arch
> independent parts of irq handling. Arch specific patches will follow.
> 
> Can anyone give a feedback, please ? Is it post 2.6 project ?

Thanks for working on this, are there any specific build combinations, 
targets you'd like it tested on?

	Zwane
-- 
function.linuxpower.ca
