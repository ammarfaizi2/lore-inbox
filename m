Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129759AbRCGOwe>; Wed, 7 Mar 2001 09:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129854AbRCGOwZ>; Wed, 7 Mar 2001 09:52:25 -0500
Received: from jalon.able.es ([212.97.163.2]:34020 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129564AbRCGOwN>;
	Wed, 7 Mar 2001 09:52:13 -0500
Date: Wed, 7 Mar 2001 15:51:24 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J . A . Magallon" <jamagallon@able.es>,
        Phil Oester <kernel@theoesters.com>, linux-kernel@vger.kernel.org
Subject: Re: Error compiling aic7xxx driver on 2.4.2-ac13
Message-ID: <20010307155124.A3283@werewolf.able.es>
In-Reply-To: <20010307010423.A1132@werewolf.able.es> <E14aSAu-0001pw-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14aSAu-0001pw-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Mar 07, 2001 at 01:51:29 +0100
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.07 Alan Cox wrote:
> 
> Im not too worried about this right now since as Al Viro pointed out the
> libdb use is unneeded. 
> 

The real fact is if aicasm is needed, not how to implement aicasm.
Is it possible to distribute in kernel just the output of aicasm, the sequencer
code, and that the author packages the assembler in a separate tgz ?

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac13 #3 SMP Wed Mar 7 00:09:17 CET 2001 i686

