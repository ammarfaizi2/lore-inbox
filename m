Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbTBSWo1>; Wed, 19 Feb 2003 17:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbTBSWo1>; Wed, 19 Feb 2003 17:44:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49859 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262425AbTBSWo0>;
	Wed, 19 Feb 2003 17:44:26 -0500
Date: Wed, 19 Feb 2003 14:38:41 -0800 (PST)
Message-Id: <20030219.143841.87628436.davem@redhat.com>
To: ionut@badula.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       James.Bottomley@steeleye.com
Subject: Re: [PATCH] add new DMA_ADDR_T_SIZE define
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0302191750580.29393-100000@guppy.limebrokerage.com>
References: <20030219.142952.27404695.davem@redhat.com>
	<Pine.LNX.4.44.0302191750580.29393-100000@guppy.limebrokerage.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ion Badulescu <ionut@badula.org>
   Date: Wed, 19 Feb 2003 17:53:02 -0500 (EST)
   
   So is the current wisdom something like "always treat dma_addr_t as a u64
   and be happy"?

Yes.
