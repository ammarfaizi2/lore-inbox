Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317005AbSHaKHe>; Sat, 31 Aug 2002 06:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317025AbSHaKHd>; Sat, 31 Aug 2002 06:07:33 -0400
Received: from e.kth.se ([130.237.48.5]:28938 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S317005AbSHaKHd>;
	Sat, 31 Aug 2002 06:07:33 -0400
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Sync arch/alpha/kernel/entry.S with asm/unistd.h
References: <yw1x8z2oca90.fsf@zaphod.guide>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 31 Aug 2002 12:11:53 +0200
In-Reply-To: mru@users.sourceforge.net's message of "30 Aug 2002 23:22:35 +0200"
Message-ID: <yw1xr8gfz6ae.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@users.sourceforge.net (Måns Rullgård) writes:

> This adds some (non-implemented) syscalls to entry.S with the same
> numbers as in asm/unistd.h

I forgot to say the patch is against 2.4.19.

-- 
Måns Rullgård
mru@users.sf.net
