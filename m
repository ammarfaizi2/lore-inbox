Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbSLWJSq>; Mon, 23 Dec 2002 04:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbSLWJSq>; Mon, 23 Dec 2002 04:18:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41196 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265446AbSLWJSp>;
	Mon, 23 Dec 2002 04:18:45 -0500
Date: Mon, 23 Dec 2002 01:21:05 -0800 (PST)
Message-Id: <20021223.012105.52767427.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Embed __this_module in module itself.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021223084155.8C2D22C053@lists.samba.org>
References: <20021223084155.8C2D22C053@lists.samba.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Mon, 23 Dec 2002 19:38:41 +1100

   Please check out this patch, which embeds the module structure into
   the module itself (in ".gnu.linkonce.this_module").  Slight
   simplification, and gives Dave that page back, as I promised.

Looks like the right idea to me Rusty.
