Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269680AbSIRTQw>; Wed, 18 Sep 2002 15:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269681AbSIRTQv>; Wed, 18 Sep 2002 15:16:51 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:64209 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S269680AbSIRTQq> convert rfc822-to-8bit; Wed, 18 Sep 2002 15:16:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read-Copy Update 2.5.36
Date: Wed, 18 Sep 2002 21:21:32 +0200
X-Mailer: KMail [version 1.4]
Cc: dipankar@in.ibm.com
References: <200209181937.39385.m.c.p@gmx.net> <20020919001018.C23055@in.ibm.com> <20020919003332.E23055@in.ibm.com>
In-Reply-To: <20020919003332.E23055@in.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209182121.32442.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 September 2002 21:03, Dipankar Sarma wrote:

Hi Dipankar,

> > Ok, so DEFINE_PER_CPU() has now been excluded when MODULE is defined.
> > The included patch below should fix that.
>
> Here is the entire rcu_poll patch with this fix -
thanks alot. For now in my -mcp tree, 2.5.36-mcp2 to come soon :)

Builds fine with 2.5.36 vanilla and -mcp tree.

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
