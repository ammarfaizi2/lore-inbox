Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbSKZEvT>; Mon, 25 Nov 2002 23:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbSKZEvT>; Mon, 25 Nov 2002 23:51:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18831 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262824AbSKZEvS>;
	Mon, 25 Nov 2002 23:51:18 -0500
Date: Mon, 25 Nov 2002 20:57:18 -0800 (PST)
Message-Id: <20021125.205718.43851459.davem@redhat.com>
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ipv4/af_inet.c: remove include seq_file.h and
 proc_fs.h, not needed anymore
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021125012759.GX31074@conectiva.com.br>
References: <20021125012759.GX31074@conectiva.com.br>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Sun, 24 Nov 2002 23:27:59 -0200
   
   master.kernel.org:/home/acme/BK/net-2.5
   
   	Now there are six outstanding changesets.

Thanks Arnaldo, I've pulled all of your changes.

Thanks for keeping this SEQ file conversion work
on the move :)
