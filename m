Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315264AbSEQB0o>; Thu, 16 May 2002 21:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSEQB0n>; Thu, 16 May 2002 21:26:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9622 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315264AbSEQB0m>;
	Thu, 16 May 2002 21:26:42 -0400
Date: Thu, 16 May 2002 18:13:31 -0700 (PDT)
Message-Id: <20020516.181331.44763514.davem@redhat.com>
To: heidl@zib.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPPoE for sparc
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1021557826.12791.56.camel@csr-pc6>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Sebastian Heidl <heidl@zib.de>
   Date: 16 May 2002 16:03:45 +0200
   
   Is there a particular reason why the PPPoE driver is not
   offered when I do something like "make ARCH=sparc menuconfig" ?
   Sure it's not listed in config.in for sparc (2.4.19-pre7) but
   why ?
   
Nobody got around to adding it, if you send me a patch
that adds it I'll put it into my tree and forward it on
to Marcelo/Linus.
