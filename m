Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbTCOWwZ>; Sat, 15 Mar 2003 17:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbTCOWwY>; Sat, 15 Mar 2003 17:52:24 -0500
Received: from horkos.telenet-ops.be ([195.130.132.45]:32703 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S261609AbTCOWwY>; Sat, 15 Mar 2003 17:52:24 -0500
From: Karl Vogel <karl.vogel@seagha.com>
Subject: Re: v2.5.32 - v2.5.64+ Locks at Boot with Athlon Machine
To: linux-kernel@vger.kernel.org
Date: Sun, 16 Mar 2003 00:03:07 +0100
References: <20030315135007$3ee8@gated-at.bofh.it> <20030315135007$10c9@gated-at.bofh.it> <20030315135007$71e8@gated-at.bofh.it>
User-Agent: KNode/0.7.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030315230315.13F7D83C19@horkos.telenet-ops.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Did you turn on console support in your .config?
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> You will need to compile input support into the kernel (i.e. not as a
> module): CONFIG_INPUT=y
> I hope this helps,

Whoopsy.. was missing the first 2. Stupid error on my part. Thanks for the
tip.
