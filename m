Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290508AbSBKVt4>; Mon, 11 Feb 2002 16:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290520AbSBKVtx>; Mon, 11 Feb 2002 16:49:53 -0500
Received: from mx2.elte.hu ([157.181.151.9]:45960 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290508AbSBKVtm>;
	Mon, 11 Feb 2002 16:49:42 -0500
Date: Tue, 12 Feb 2002 00:47:38 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: scheduler, and per-arch switch_to
In-Reply-To: <3C67C740.43AAD437@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0202120047080.15386-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Feb 2002, Jeff Garzik wrote:

> Do we really care about the third arg to the switch_to() macro?

we dont need it anymore, i'll remove it in my next patchset (if you dont
beat me at it).

	Ingo

