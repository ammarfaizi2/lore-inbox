Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318650AbSH1D7w>; Tue, 27 Aug 2002 23:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318652AbSH1D7w>; Tue, 27 Aug 2002 23:59:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6037 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318650AbSH1D7w>;
	Tue, 27 Aug 2002 23:59:52 -0400
Date: Tue, 27 Aug 2002 20:58:30 -0700 (PDT)
Message-Id: <20020827.205830.72711261.davem@redhat.com>
To: ldb@ldb.ods.org
Cc: s.biggs@softier.com, linux-kernel@vger.kernel.org
Subject: Re: Bug in kernel code?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1030507070.1489.32.camel@ldb>
References: <3D6BD62C.581.ACEBAD@localhost>
	<20020827.203946.102043898.davem@redhat.com>
	<1030507070.1489.32.camel@ldb>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Luca Barbieri <ldb@ldb.ods.org>
   Date: 28 Aug 2002 05:57:50 +0200

   On Wed, 2002-08-28 at 05:39, David S. Miller wrote:
   > Realistically possible with any known configuration?

   How about replacing the loop with ffs/__ffs that would be more
   elegant, shorter and avoid any problem or doubt?
   
This is getting rediculious.  You can pursue this further
if you want, but I think we've wasted enough time with
this non-bug.

Who is getting bootup failures due to this problem?
Answer: nobody
