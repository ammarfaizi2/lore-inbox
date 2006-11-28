Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935695AbWK1Inw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935695AbWK1Inw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 03:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935704AbWK1InW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 03:43:22 -0500
Received: from smtp.ono.com ([62.42.230.12]:2811 "EHLO resmaa04.ono.com")
	by vger.kernel.org with ESMTP id S935703AbWK1Ims (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 03:42:48 -0500
Date: Tue, 28 Nov 2006 09:42:47 +0100
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: oprofile as user
Message-ID: <20061128094247.56ea7513@werewolf-wl>
X-Mailer: Claws Mail 2.6.0cvs65 (GTK+ 2.10.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi....

First of all, thanks for oprofile !
It's the first tool I can really use to profile my app, with a ton of
dynamically loaded plugins and without having to link everything
statically...

But, it there any sane way to use it as non-root user ?
Is there any alternative ?
I'm even thinking of suid'ing opcontrol.
I tried sysprof, but it locks the machine as soon as I load the module.
I use the latest -mm kernel.

Any ideas ?

TIA

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.1 (Cooker) for i586
Linux 2.6.18-jam14 (gcc 4.1.2 20061110 (prerelease) (4.1.2-0.20061110.1mdv2007.1)) #1 SMP PREEMPT
