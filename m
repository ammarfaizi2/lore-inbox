Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263286AbSJCKzi>; Thu, 3 Oct 2002 06:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263287AbSJCKzi>; Thu, 3 Oct 2002 06:55:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61904 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263286AbSJCKzh>;
	Thu, 3 Oct 2002 06:55:37 -0400
Date: Thu, 03 Oct 2002 03:53:52 -0700 (PDT)
Message-Id: <20021003.035352.132919623.davem@redhat.com>
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
Newsgroups: hometree.linux.kernel
Subject: Re: Sequence of IP fragment packets on the wire
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <anh7es$mpl$1@forge.intermeta.de>
References: <anh7es$mpl$1@forge.intermeta.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Henning P. Schmiedehausen" <hps@intermeta.de>
   Date: Thu, 3 Oct 2002 10:51:08 +0000 (UTC)

   as far as I can see, Linux sends out fragmented IP packets
   "butt-first":
   
Right.
   
   Is there a way to configure this? Maybe even connection specific? 

No.
