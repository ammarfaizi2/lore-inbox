Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277859AbRJKAkh>; Wed, 10 Oct 2001 20:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277885AbRJKAk1>; Wed, 10 Oct 2001 20:40:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1672 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277859AbRJKAkW>;
	Wed, 10 Oct 2001 20:40:22 -0400
Date: Wed, 10 Oct 2001 17:40:13 -0700 (PDT)
Message-Id: <20011010.174013.38712232.davem@redhat.com>
To: Thierry.Coutelier@linux.lu
Cc: lartc@mailman.ds9a.nl, linux-kernel@vger.kernel.org, Kuznet@Ms2.Inr.Ac.Ru
Subject: Re: Kernel patch for cls_u32.c 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BC439AB.B9B83B65@linux.lu>
In-Reply-To: <3BC439AB.B9B83B65@linux.lu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thierry Coutelier <Thierry.Coutelier@linux.lu>
   Date: Wed, 10 Oct 2001 14:06:03 +0200

   To solve a problem while listing filters you may add this patch.
   It works for all kernel versions from  2.4.6 to 2.4.11
   It wold be cool to have it in the next kernel release.
   
What is the "problem"?  Why should it only call the walker function
on entries which equal tp->root?  This change doesn't make any sense
to me.

You need to describe the problem and how your changes solve
that problem.

Franks a lot,
David S. Miller
davem@redhat.com


