Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267660AbUIUMzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267660AbUIUMzj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 08:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267661AbUIUMzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 08:55:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:65152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267660AbUIUMzd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 08:55:33 -0400
Date: Tue, 21 Sep 2004 08:54:54 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel connector - userspace <-> kernelspace "linker".
In-Reply-To: <20040921124623.GA6942@uganda.factory.vocord.ru>
Message-ID: <Pine.LNX.4.53.0409210850460.3314@chaos.analogic.com>
References: <1095331899.18219.58.camel@uganda> <20040921124623.GA6942@uganda.factory.vocord.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
This looks like a thinly veiled attempt to provide kernel
hooks so that non-GPL user-mode code can execute within
the kernel and trash it. I think the kernel developers
are smart enough so they won't allow any priviliged
kernel-mode 'callback' to user code.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

