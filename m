Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278648AbRJXQh1>; Wed, 24 Oct 2001 12:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278647AbRJXQhQ>; Wed, 24 Oct 2001 12:37:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3211 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278643AbRJXQgP>;
	Wed, 24 Oct 2001 12:36:15 -0400
Date: Wed, 24 Oct 2001 09:36:27 -0700 (PDT)
Message-Id: <20011024.093627.68149691.davem@redhat.com>
To: baggins@sith.mimuw.edu.pl
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: acenic breakage in 2.4.13-pre
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011024180414.A16921@sith.mimuw.edu.pl>
In-Reply-To: <20011024.082925.68578636.davem@redhat.com>
	<20011024180414.A16921@sith.mimuw.edu.pl>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
   Date: Wed, 24 Oct 2001 18:04:14 +0200

   On Wed, 24 Oct 2001, David S. Miller wrote:
   
   > Do you have CONFIG_HIGHMEM enabled?  If so, please try with
   > it turned off.
   
   Nope. No HIGHMEM here.

Thanks, one more question :-)  What compiler is on your
machine where this driver was built?  Are you using RH7.1
or some variant of gcc-3.x by chance?

Franks a lot,
David S. Miller
davem@redhat.com

