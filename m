Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbTEFHlw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 03:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbTEFHlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 03:41:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60389 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262437AbTEFHlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 03:41:51 -0400
Date: Mon, 05 May 2003 23:46:28 -0700 (PDT)
Message-Id: <20030505.234628.52181493.davem@redhat.com>
To: Steve@ChyGwyn.com, steve@gw.chygwyn.com
Cc: acme@conectiva.com.br, hch@infradead.org,
       linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Remains of seq_file conversion for DECnet, plus fixes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305041843.TAA04564@gw.chygwyn.com>
References: <20030502015409.GC5356@conectiva.com.br>
	<200305041843.TAA04564@gw.chygwyn.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Steven Whitehouse <steve@gw.chygwyn.com>
   Date: Sun, 4 May 2003 19:43:51 +0100 (BST)

   Now that I'm back again, here is the first patch again with
   kfree_release renamed as suggested to seq_release_private,

Since there have been no objections I'll apply this and
your decnet patch that makes use of the new interfaces.

Thanks.
