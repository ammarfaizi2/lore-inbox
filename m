Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSLBHgW>; Mon, 2 Dec 2002 02:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbSLBHgV>; Mon, 2 Dec 2002 02:36:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60351 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261286AbSLBHgV>;
	Mon, 2 Dec 2002 02:36:21 -0500
Date: Sun, 01 Dec 2002 23:41:28 -0800 (PST)
Message-Id: <20021201.234128.13598110.davem@redhat.com>
To: acme@conectiva.com.br
Cc: sk@deeptown.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp: fix seq_file handling bug
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021130153600.GF30931@conectiva.com.br>
References: <20021130153600.GF30931@conectiva.com.br>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Sat, 30 Nov 2002 13:36:00 -0200

   	Please pull from:
   
   bk://kernel.bkbits.net/acme/net-2.5

Pulled, thanks.

   	Now there is just this outstanding changeset. Now I have
   some time to devote to fixing /proc/net/tcp seq_file handling.
   
Please let me know once you have this fixed, as it is
holding up my net merges :-)
