Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277293AbRJQX30>; Wed, 17 Oct 2001 19:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277291AbRJQX3Q>; Wed, 17 Oct 2001 19:29:16 -0400
Received: from cx739861-a.dt1.sdca.home.com ([24.5.164.61]:19205 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S277290AbRJQX3J>; Wed, 17 Oct 2001 19:29:09 -0400
Date: Wed, 17 Oct 2001 16:29:41 -0700
To: linux-kernel@vger.kernel.org
Cc: Bill Huey <billh@gnuppy.monkey.org>
Subject: Kernel Link Problems
Message-ID: <20011017162941.A32145@gnuppy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: Bill Huey <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm running the 2.4.12-ac3 and I get this while linking vmlinuz:

	ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o piggy.o
	ld: bvmlinux: Not enough room for program headers (allocated 2, need 3)
	ld: final link failed: Bad value

What's going on and how do I fix this ?

Thanks

bill


