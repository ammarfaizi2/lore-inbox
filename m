Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317211AbSEXRqU>; Fri, 24 May 2002 13:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317224AbSEXRqT>; Fri, 24 May 2002 13:46:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41600 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317211AbSEXRqN>;
	Fri, 24 May 2002 13:46:13 -0400
Date: Fri, 24 May 2002 10:31:04 -0700 (PDT)
Message-Id: <20020524.103104.107001160.davem@redhat.com>
To: dent@cosy.sbg.ac.at
Cc: alan@lxorguk.ukuu.org.uk, tori@ringstrom.mine.nu, imipak@yahoo.com,
        linux-kernel@vger.kernel.org
Subject: Re: Linux crypto?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.05.10205241938290.11037-100000@mausmaki.cosy.sbg.ac.at>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
   Date: Fri, 24 May 2002 19:42:45 +0200 (MET DST)
   
   what about taking out the libdes stuff, and make it available from
   elsewhere, and hook it into the kernel as a module?
   the main kernel could come with a null crypto implementation - which
   makes no sense to use, but it will allow to meintain the whole system
   without having to worry about the crypto stuff per se (this shouldn't
   change very much in any case)

The US laws cover even things that are meant to allow crypto.
