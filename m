Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbSJaDRg>; Wed, 30 Oct 2002 22:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265146AbSJaDRg>; Wed, 30 Oct 2002 22:17:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24256 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265140AbSJaDRe>;
	Wed, 30 Oct 2002 22:17:34 -0500
Date: Wed, 30 Oct 2002 19:13:50 -0800 (PST)
Message-Id: <20021030.191350.79592740.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: boissiere@adiglobal.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5] October 30, 2002
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021031.121609.71851601.yoshfuji@linux-ipv6.org>
References: <20021031.114832.59687399.yoshfuji@linux-ipv6.org>
	<20021030.184443.87162307.davem@redhat.com>
	<20021031.121609.71851601.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Thu, 31 Oct 2002 12:16:09 +0900 (JST)

   In article <20021030.184443.87162307.davem@redhat.com> (at Wed, 30 Oct 2002 18:44:43 -0800 (PST)), "David S. Miller" <davem@redhat.com> says:
   
   > Absolutely not, we do not put improperly architected code into the
   > tree first then clean it up later.
   
   That patch do NOT change current architecture so above is unfair.

Ok, I correct myself, this patch adds more dependencies on badly
architected area making it _harder_ for us to clean it up.
