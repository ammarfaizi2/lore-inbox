Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290669AbSBLBLV>; Mon, 11 Feb 2002 20:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290675AbSBLBLL>; Mon, 11 Feb 2002 20:11:11 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:21508 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S290669AbSBLBLC>; Mon, 11 Feb 2002 20:11:02 -0500
Message-ID: <3C686BA0.5D39CBCA@linux-m68k.org>
Date: Tue, 12 Feb 2002 02:10:56 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: thread_info implementation
In-Reply-To: <20020211205048.GA5401@krispykreme>
		<20020211.164617.39155905.davem@redhat.com>
		<3C68685F.90C3AAA4@linux-m68k.org> <20020211.165730.59656439.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"David S. Miller" wrote:

> It requires ugly scripts that parse assembler files if you want it to
> work in a cross compilation requirement.  Check out
> arch/sparc64/kernel/check_asm.sh and the "check_asm" rule in the
> Makefile or the same directory in older trees to see what I mean.

Why is that complicated???
I crosscompile m68k/ppc all the time without problems, what am I doing
wrong?

bye, Roman
