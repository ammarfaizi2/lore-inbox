Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271735AbRHQWGE>; Fri, 17 Aug 2001 18:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271728AbRHQWFz>; Fri, 17 Aug 2001 18:05:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46610 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271734AbRHQWFt>; Fri, 17 Aug 2001 18:05:49 -0400
Subject: Re: 2.4.8 Resource leaks + limits
To: riel@conectiva.com.br (Rik van Riel)
Date: Fri, 17 Aug 2001 23:08:17 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        mlist@intergrafix.net (Admin Mailing Lists),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0108171900260.2277-100000@duckman.distro.conectiva> from "Rik van Riel" at Aug 17, 2001 07:01:57 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Xrmr-0008Ba-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan, would you accept the trivial version of per-user
> CPU scheduling for 2.4 if there is a lot of demand ?

I'd rather it was a patch outside the main tree
