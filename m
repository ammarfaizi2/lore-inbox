Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267168AbTGLA2b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 20:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbTGLA2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 20:28:31 -0400
Received: from [212.97.163.22] ([212.97.163.22]:63213 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S267168AbTGLA2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 20:28:30 -0400
Date: Sat, 12 Jul 2003 02:43:01 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc-3.3.1 breaks kernel
Message-ID: <20030712004301.GE2791@werewolf.able.es>
References: <8avk.6lp.3@gated-at.bofh.it> <3F0F4C10.9050204@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3F0F4C10.9050204@g-house.de>; from evil@g-house.de on Sat, Jul 12, 2003 at 01:45:20 +0200
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.12, Christian Kujau wrote:
> J.A. Magallon wrote:
> > Hi all...
> > 
> > Any brave soul there is using a prerelease of gcc-3.3.1 to build kernels ?
> > (don't know if RawHide or SuSE beta or any other have that, apart from
> > MandrakeCooker).
> 
> yes, 2.4.2x and 2.5.7x build properly with Debians gcc-3.3.1 here (x86).
> 

Plz, can you tell me the exact version of gcc (date of snapshot or the
like). My cooker gcc is:

- Update to 3.3-hammer branch as of 2003/07/03

Perhaps I can dig the gcc changelogs to look for something.

This is really strange...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre2-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
