Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268710AbRHKSvp>; Sat, 11 Aug 2001 14:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268712AbRHKSvf>; Sat, 11 Aug 2001 14:51:35 -0400
Received: from zero.tech9.net ([209.61.188.187]:47880 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S268710AbRHKSv0>;
	Sat, 11 Aug 2001 14:51:26 -0400
Subject: Re: [PATCH] emu10k1 againt kernel 2.4.8
From: Robert Love <rml@tech9.net>
To: Rui Sousa <rui.p.m.sousa@clix.pt>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108110626300.1487-200000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0108110626300.1487-200000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 11 Aug 2001 14:50:47 -0400
Message-Id: <997555894.825.10.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Aug 2001 06:33:09 +0100, Rui Sousa wrote:
> Patch against kernel 2.4.8:
> 1. Fixes makefiles changes (can now be compiled as a module).
> 2. Reverts addition of joystick.c
> 3. Enables emu10k1 sequencer support.
> 4. Adds documentation for the driver new features.

Linus, please consider this patch.  It fixes a few issues in my patch
that was merged in 2.4.8.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

