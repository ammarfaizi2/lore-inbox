Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317399AbSIEKwz>; Thu, 5 Sep 2002 06:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSIEKwz>; Thu, 5 Sep 2002 06:52:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9960 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317399AbSIEKwz>;
	Thu, 5 Sep 2002 06:52:55 -0400
Date: Thu, 05 Sep 2002 03:50:08 -0700 (PDT)
Message-Id: <20020905.035008.84077522.davem@redhat.com>
To: green@namesys.com
Cc: szepe@pinerecords.com, mason@suse.com, reiser@namesys.com,
       shaggy@austin.ibm.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       linuxjfs@us.ibm.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020905135442.A19682@namesys.com>
References: <20020905054008.GH24323@louise.pinerecords.com>
	<20020904.223651.79770866.davem@redhat.com>
	<20020905135442.A19682@namesys.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Oleg Drokin <green@namesys.com>
   Date: Thu, 5 Sep 2002 13:54:42 +0400
   
   Ok, since I really like this approach, below is the patch (for 2.4) that
   demonstrates my solution.

I like it.  Now we just need a JFS version, shouldn't bee too
hard :-)

Franks a lot,
David S. Miller
davem@redhat.com
