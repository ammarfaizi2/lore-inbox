Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264810AbSKNKMe>; Thu, 14 Nov 2002 05:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264814AbSKNKMe>; Thu, 14 Nov 2002 05:12:34 -0500
Received: from ns.suse.de ([213.95.15.193]:7177 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264810AbSKNKMd>;
	Thu, 14 Nov 2002 05:12:33 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module mess in -CURRENT
References: <20021114000206.A8245@infradead.org.suse.lists.linux.kernel> <Pine.LNX.4.44.0211131655580.6810-100000@home.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 14 Nov 2002 11:19:26 +0100
In-Reply-To: Linus Torvalds's message of "14 Nov 2002 02:02:58 +0100"
Message-ID: <p731y5owj0x.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> (There are some other patches I'm still thinking about, notably kprobes
> and posix timers, but other than that my plate is fairly empty froma
> feature standpoint. And the kexec stuff I want others to test, at least
> now it's palatable to me).

How about the nanosecond stat stuff? It is needed for reliable make.

If I sent you a patch would you still consider it? It is not that intrusive, 
but needs straightforward editing in all file systems.

-Andi
