Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293576AbSBZL1R>; Tue, 26 Feb 2002 06:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293575AbSBZL1I>; Tue, 26 Feb 2002 06:27:08 -0500
Received: from pizda.ninka.net ([216.101.162.242]:4224 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292538AbSBZL04>;
	Tue, 26 Feb 2002 06:26:56 -0500
Date: Tue, 26 Feb 2002 03:24:53 -0800 (PST)
Message-Id: <20020226.032453.41634091.davem@redhat.com>
To: heidl@zib.de
Cc: nick@snowman.net, linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020226122205.B8471@csr-pc6.local>
In-Reply-To: <Pine.LNX.4.21.0202252243360.18586-100000@ns>
	<20020225.204022.62649663.davem@redhat.com>
	<20020226122205.B8471@csr-pc6.local>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Sebastian Heidl <heidl@zib.de>
   Date: Tue, 26 Feb 2002 12:22:05 +0100

   I think these are 3C996-T. Is there any information about the
   compatibility of TG3 to TG2 ?

Totally different chip, but there are subtle similarities all over
the place.  Ie. if you knew how to program the tg2, or even were just
familiar with the acenic driver, the tg3 stuff looks familiar.
