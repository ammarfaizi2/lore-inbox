Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSGHHZy>; Mon, 8 Jul 2002 03:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316799AbSGHHZx>; Mon, 8 Jul 2002 03:25:53 -0400
Received: from ns.suse.de ([213.95.15.193]:60934 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316795AbSGHHZw>;
	Mon, 8 Jul 2002 03:25:52 -0400
To: Madhavi <madhavis@sasken.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPv6 multiple routing tables
References: <Pine.LNX.4.33.0207081051570.1159-100000@pcz-madhavis.sasken.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 08 Jul 2002 09:28:28 +0200
In-Reply-To: Madhavi's message of "8 Jul 2002 07:26:59 +0200"
Message-ID: <p737kk6wueb.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Madhavi <madhavis@sasken.com> writes:

> Hi
> 
> Does linux kernel version 2.4.18 support multiple routing tables for IPv6?
> Otherwise, is there some patch available for this support?

It's not supported. While there is some code for it in the kernel
it is not functional.

-Andi
