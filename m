Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966405AbWKNV6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966405AbWKNV6x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966406AbWKNV6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:58:53 -0500
Received: from smtp.ono.com ([62.42.230.12]:10782 "EHLO resmaa03.ono.com")
	by vger.kernel.org with ESMTP id S966405AbWKNV6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:58:52 -0500
Date: Tue, 14 Nov 2006 22:58:48 +0100
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: SMP and ACPI
Message-ID: <20061114225848.160cc46f@werewolf-wl>
X-Mailer: Claws Mail 2.6.0cvs40 (GTK+ 2.10.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

Stupid question of the day: is it still needed to select ACPI manually to
get SMP working, or does SMP select the minimal part of ACPI that is needed ?

TIA

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.1 (Cooker) for i586
Linux 2.6.18-jam12 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #1 SMP PREEMPT
