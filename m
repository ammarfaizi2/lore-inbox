Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVADNaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVADNaO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVADNaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:30:14 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:37831 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261638AbVADN3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:29:07 -0500
Message-Id: <200501041327.j04DRhfQ007850@laptop11.inf.utfsm.cl>
To: Felipe Alfaro Solana <lkml@mac.com>
cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@stusta.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@debian.org>
Subject: Re: starting with 2.7 
In-Reply-To: Message from Felipe Alfaro Solana <lkml@mac.com> 
   of "Mon, 03 Jan 2005 23:03:53 BST." <5B2E0ED4-5DD3-11D9-892B-000D9352858E@mac.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 04 Jan 2005 10:27:43 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <lkml@mac.com> said:

[...]

> Gosh! I bought an ATI video card, I bought a VMware license, etc.... I 
> want to keep using them. Changing a "stable" kernel will continuously 
> annoy users and vendors.

If you are sooo attached to this, just keep a distribution for which
vendors give you drivers. But when the vendor decides the product has to
die to get you to buy the next "completely redone" (== minor fixes and
updates) version, you are stranded for good.

> I think new developments will force a 2.7 branch: when 2.6 feature set 
> stabilizes, people will keep more time testing a stable, relatively 
> static kernel base, finding bugs, instead of trying to keep up with 
> changes.

And when 2.7 opens, very few developers will tend 2.6; and as 2.7 diverges
from it, fewer and fewer fixes will find their way back. And so you finally
get a rock-stable (== unchanging) 2.6, but hopelessly out of date and thus
unfixable (if nothing else because there are no people around who remember
how it worked).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
