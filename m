Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289476AbSAJO7h>; Thu, 10 Jan 2002 09:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289477AbSAJO71>; Thu, 10 Jan 2002 09:59:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:35712 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289476AbSAJO7P>;
	Thu, 10 Jan 2002 09:59:15 -0500
Date: Thu, 10 Jan 2002 06:58:19 -0800 (PST)
Message-Id: <20020110.065819.41634244.davem@redhat.com>
To: root@chaos.analogic.com
Cc: david.balazic@uni-mb.si, matthias.andree@stud.uni-dortmund.de,
        linux-kernel@vger.kernel.org
Subject: Re: Simple local DOS
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.3.95.1020110090502.5205A-100000@chaos.analogic.com>
In-Reply-To: <3C3D9B2B.2DDB72CB@uni-mb.si>
	<Pine.LNX.3.95.1020110090502.5205A-100000@chaos.analogic.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Richard B. Johnson" <root@chaos.analogic.com>
   Date: Thu, 10 Jan 2002 09:07:51 -0500 (EST)
   
   Ctrl-ALT-F12 selects VT mode from a locked X-window, ALT-F1 gets you
   to the first VT, ALT-F2, next, etc.
   No problem at all.

Only if X services the keypress, in his case X is blocked on
stdout/stderr output so it won't.

Franks a lot,
David S. Miller
davem@redhat.com
