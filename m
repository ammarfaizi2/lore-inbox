Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265164AbSIWDOA>; Sun, 22 Sep 2002 23:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265256AbSIWDOA>; Sun, 22 Sep 2002 23:14:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31412 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265164AbSIWDN7>;
	Sun, 22 Sep 2002 23:13:59 -0400
Date: Sun, 22 Sep 2002 20:09:13 -0700 (PDT)
Message-Id: <20020922.200913.103735526.davem@redhat.com>
To: ahu@ds9a.nl
Cc: eran@nbase.co.il, linux-kernel@vger.kernel.org,
       bart.de.schuymer@pandora.be
Subject: Re: Kernel 2.5.38 EBTables breakage
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020922111000.GA17169@outpost.ds9a.nl>
References: <3D8D8660.80905@nbase.co.il>
	<20020922111000.GA17169@outpost.ds9a.nl>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: bert hubert <ahu@ds9a.nl>
   Date: Sun, 22 Sep 2002 13:10:00 +0200

   On Sun, Sep 22, 2002 at 11:59:12AM +0300, Eran Man wrote:
   > It seems like the EBTables merge in 2.5.38 is incomplete:
   
   With the following patch it at least compiles in 2.5.38
   
Applied.

I'm not surprised something went wrong, recall all of the comments
I had about your patch format Bert?  Different base directories et al.

