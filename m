Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132153AbQLOHID>; Fri, 15 Dec 2000 02:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLOHHx>; Fri, 15 Dec 2000 02:07:53 -0500
Received: from takayasu.center.osakafu-u.ac.jp ([157.16.240.30]:63692 "EHLO
	takayasu.center.osakafu-u.ac.jp") by vger.kernel.org with ESMTP
	id <S131966AbQLOHHu>; Fri, 15 Dec 2000 02:07:50 -0500
To: neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: failed in BUG() at fs/buffer.c:765
In-Reply-To: <14904.44216.352364.618062@notabene.cse.unsw.edu.au>
In-Reply-To: <20001214191242E.ark@center.osakafu-u.ac.jp>
	<14904.44216.352364.618062@notabene.cse.unsw.edu.au>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Capitol Reef)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20001215153714C.ark@center.osakafu-u.ac.jp>
Date: Fri, 15 Dec 2000 15:37:14 +0900
From: Atsuhiro Kojima <ark@center.osakafu-u.ac.jp>
X-Dispatcher: imput version 991025(IM133)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

> The simplest fix for this is the patch below.  Exactly what will get
> into test13 has not yet been decided.
> 
> NeilBrown

Thanks for your advice.
I will try it soon, maybe tonight or tomorrow.
---
Atsuhiro Kojima
Library & Science Information Center, Osaka Prefecture University.
E-mail: ark@center.osakafu-u.ac.jp
http://cuvier.center.osakafu-u.ac.jp/ark/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
