Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSJVFYC>; Tue, 22 Oct 2002 01:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262230AbSJVFYC>; Tue, 22 Oct 2002 01:24:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4072 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262224AbSJVFXo>;
	Tue, 22 Oct 2002 01:23:44 -0400
Date: Mon, 21 Oct 2002 22:21:30 -0700 (PDT)
Message-Id: <20021021.222130.64514976.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: landley@trommello.org, zippel@linux-m68k.org, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, akpm@zip.com.au, davej@suse.de,
       boissiere@adiglobal.com, mingo@redhat.com, alan@redhat.com
Subject: Re: 2.6: Shortlist of Missing Features 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021022043451.46C792C053@lists.samba.org>
References: <200210202144.59787.landley@trommello.org>
	<20021022043451.46C792C053@lists.samba.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Tue, 22 Oct 2002 12:26:26 +1000
   
   > o Ready - Zerocopy NFS (Hirokazu Takahashi)=20
   > http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0429.html
   
   This is really up to Dave.  I thought he was already merging it?
   
The net/ipv{4,6} infrastructure is in, the nfs maintainers just
need to put in the sunrpc/nfs* bits.  :-)
