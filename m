Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285944AbRLHVAx>; Sat, 8 Dec 2001 16:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285942AbRLHVAo>; Sat, 8 Dec 2001 16:00:44 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:57304 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S285941AbRLHVAY>; Sat, 8 Dec 2001 16:00:24 -0500
From: Willy Tarreau <wtarreau@free.fr>
Message-Id: <200112082100.fB8L0LL01793@ns.home.local>
Subject: Re: 2.4.14/16 load reboots
To: belg4mit@dirty-bastard.pthbb.org
Date: Sat, 8 Dec 2001 22:00:21 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I had the same problem with a kernel which contained a damaged vmlinux.lds.
Did you compile a fresh kernel or play with patches on top of an old kernel
which was compiled many times ?

Regards,
Willy

