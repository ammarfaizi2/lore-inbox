Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274630AbSITCZV>; Thu, 19 Sep 2002 22:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274631AbSITCZV>; Thu, 19 Sep 2002 22:25:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17561 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274630AbSITCZU>;
	Thu, 19 Sep 2002 22:25:20 -0400
Date: Thu, 19 Sep 2002 19:20:48 -0700 (PDT)
Message-Id: <20020919.192048.80494959.davem@redhat.com>
To: ak@suse.de
Cc: akpm@digeo.com, taka@valinux.co.jp, alan@lxorguk.ukuu.org.uk,
       neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020920042819.A1289@wotan.suse.de>
References: <20020920040619.A30304@wotan.suse.de>
	<20020919.190154.57630807.davem@redhat.com>
	<20020920042819.A1289@wotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Fri, 20 Sep 2002 04:28:19 +0200
   
   You cannot really use these instructions on Athlon,

I know that Athlon lacks these instructions, they are p4 sse2
only.
