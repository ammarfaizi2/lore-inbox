Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279934AbRJaCaG>; Tue, 30 Oct 2001 21:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279956AbRJaC34>; Tue, 30 Oct 2001 21:29:56 -0500
Received: from trifle.nips.ac.jp ([133.48.76.39]:30863 "HELO trifle.nips.ac.jp")
	by vger.kernel.org with SMTP id <S279934AbRJaC3r>;
	Tue, 30 Oct 2001 21:29:47 -0500
To: gotom@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Intel 845 support for agpgart
In-Reply-To: <w53zo68bs69.wl@megaela.fe.dis.titech.ac.jp>
In-Reply-To: <20011031074918B.shy@trifle.nips.ac.jp>
	<w53zo68bs69.wl@megaela.fe.dis.titech.ac.jp>
X-Mailer: Mew version 1.94.2 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011031113003B.shy@trifle.nips.ac.jp>
Date: Wed, 31 Oct 2001 11:30:03 +0900
From: Shyouzou Sugitani <shy@trifle.nips.ac.jp>
X-Dispatcher: imput version 20000414(IM141)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At Wed, 31 Oct 2001 08:54:06 +0900
GOTO Masanori <gotom@debian.org> wrote:
> Aha, this patch already sent by me some hours before 
> and its function is totally same :-)

OK, I read your patch which appeared in Linux-Kernel Archive and found
that its function is not totally same.

The MCHCFG register of i845 is only 8bits.

--
Regards,
Shyouzou Sugitani <shy@debian.or.jp>
