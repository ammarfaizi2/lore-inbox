Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282041AbRKZSgE>; Mon, 26 Nov 2001 13:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282019AbRKZSeQ>; Mon, 26 Nov 2001 13:34:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:34176 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282020AbRKZSdi>;
	Mon, 26 Nov 2001 13:33:38 -0500
Date: Mon, 26 Nov 2001 10:33:27 -0800 (PST)
Message-Id: <20011126.103327.18298379.davem@redhat.com>
To: mingo@elte.hu
Cc: bcrl@redhat.com, velco@fadata.bg, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Scalable page cache
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0111262115261.17043-100000@localhost.localdomain>
In-Reply-To: <20011126131641.A13955@redhat.com>
	<Pine.LNX.4.33.0111262115261.17043-100000@localhost.localdomain>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ingo Molnar <mingo@elte.hu>
   Date: Mon, 26 Nov 2001 21:29:39 +0100 (CET)
   
   so i'm not against removing (or improving) the hash [our patch in fact
   just left the hash alone], but the patch presented is not a win IMO.

Maybe you should give it a test to find out for sure :)
