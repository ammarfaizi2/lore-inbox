Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287488AbSBZNSM>; Tue, 26 Feb 2002 08:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287134AbSBZNSC>; Tue, 26 Feb 2002 08:18:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:9600 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S287045AbSBZNRy>;
	Tue, 26 Feb 2002 08:17:54 -0500
Date: Tue, 26 Feb 2002 05:13:40 -0800 (PST)
Message-Id: <20020226.051340.74738485.davem@redhat.com>
To: heidl@zib.de
Cc: nick@snowman.net, linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020226123949.C8471@csr-pc6.local>
In-Reply-To: <20020226122205.B8471@csr-pc6.local>
	<20020226.032453.41634091.davem@redhat.com>
	<20020226123949.C8471@csr-pc6.local>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Sebastian Heidl <heidl@zib.de>
   Date: Tue, 26 Feb 2002 12:39:49 +0100

   I guess nobody was crazy enough yet to try to load a tg2-firmware on a tg3 ?
   Only as there are some utils to build a customized firmware for the tg2.

Different cpus, tg3 uses StrongARM and tg2 uses a lobotomized MIPS.
