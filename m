Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267453AbSLEVH3>; Thu, 5 Dec 2002 16:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267429AbSLEVEP>; Thu, 5 Dec 2002 16:04:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61918 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267439AbSLEU7o>;
	Thu, 5 Dec 2002 15:59:44 -0500
Date: Thu, 05 Dec 2002 13:04:08 -0800 (PST)
Message-Id: <20021205.130408.24168896.davem@redhat.com>
To: pavel@suse.cz
Cc: ralf@linux-mips.org, torvalds@transmeta.com, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, anton@samba.org, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021204112236.GC309@elf.ucw.cz>
References: <20021202085923.A11711@linux-mips.org>
	<20021202.000154.38083110.davem@redhat.com>
	<20021204112236.GC309@elf.ucw.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pavel Machek <pavel@suse.cz>
   Date: Wed, 4 Dec 2002 12:22:36 +0100

   Right option might be to kill devio.c :-). It has other problems, too,
   IIRC.

Well, something has to replace it so that I can download pictures
from my Canon EOS D30 in userspace :-)
