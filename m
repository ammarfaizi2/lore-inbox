Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316827AbSFDV3M>; Tue, 4 Jun 2002 17:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316828AbSFDV3M>; Tue, 4 Jun 2002 17:29:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45697 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316827AbSFDV3K>;
	Tue, 4 Jun 2002 17:29:10 -0400
Date: Tue, 04 Jun 2002 14:24:24 -0700 (PDT)
Message-Id: <20020604.142424.63998011.davem@redhat.com>
To: thockin@hockin.org
Cc: kloczek@rudy.mif.pg.gda.pl, jgarzik@mandrakesoft.com,
        austin@coremetrics.com, linux-kernel@vger.kernel.org
Subject: Re: Max groups at 32?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206042118.g54LINc12880@www.hockin.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tim Hockin <thockin@hockin.org>
   Date: Tue, 4 Jun 2002 14:18:22 -0700 (PDT)
   
   We have a patch floating around that enables unlimited group membership at
   the kernel level, too.  We've never submitted it because it was suggested
   that we were crazy and should just bugger off.   If I thought it might be
   useful and acceptable, we could perhaps make it available in a cleanish
   form.

How do it handle userland backwards compatibility with the existing
stuff?
