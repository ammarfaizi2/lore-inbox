Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261483AbSJAEjC>; Tue, 1 Oct 2002 00:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261484AbSJAEjC>; Tue, 1 Oct 2002 00:39:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40120 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261483AbSJAEjB>;
	Tue, 1 Oct 2002 00:39:01 -0400
Date: Mon, 30 Sep 2002 21:37:33 -0700 (PDT)
Message-Id: <20020930.213733.28765330.davem@redhat.com>
To: david@gibson.dropbear.id.au
Cc: paulus@samba.org, linux-kernel@vger.kernel.org,
       linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH,RFC] Add gfp_mask to get_vm_area()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021001044226.GS10265@zax>
References: <20021001044226.GS10265@zax>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Gibson <david@gibson.dropbear.id.au>
   Date: Tue, 1 Oct 2002 14:42:26 +1000

   Dave, please consider this patch.

I'm fine with this change, but it needs to go through Linus
and Marcelo not me :-)
