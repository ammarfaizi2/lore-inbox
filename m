Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285059AbRLFIO4>; Thu, 6 Dec 2001 03:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285061AbRLFIOq>; Thu, 6 Dec 2001 03:14:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:30340 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285059AbRLFIOe>;
	Thu, 6 Dec 2001 03:14:34 -0500
Date: Thu, 06 Dec 2001 00:14:23 -0800 (PST)
Message-Id: <20011206.001423.118949508.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: kaos@ocs.com.au, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.16 for pointers to __devexit functions
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C0F27CA.59C22DEF@mandrakesoft.com>
In-Reply-To: <11777.1007619756@kao2.melbourne.sgi.com>
	<3C0F27CA.59C22DEF@mandrakesoft.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Thu, 06 Dec 2001 03:09:46 -0500
   
   Why not __attribute__((weak)) ?

This doesn't work on all platforms unfortunately :(
