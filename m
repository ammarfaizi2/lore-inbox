Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314494AbSEUIsp>; Tue, 21 May 2002 04:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316569AbSEUIso>; Tue, 21 May 2002 04:48:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40135 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314494AbSEUIso>;
	Tue, 21 May 2002 04:48:44 -0400
Date: Tue, 21 May 2002 01:34:44 -0700 (PDT)
Message-Id: <20020521.013444.121208947.davem@redhat.com>
To: beezly@beezly.org.uk
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: OOPS: ext3/sparc badness
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020521083805.GC18501@monkey.beezly.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Beresford <beezly@beezly.org.uk>
   Date: Tue, 21 May 2002 09:38:05 +0100

   The link is;
   
   http://marc.theaimsgroup.com/?l=linux-raid&m=101981888804890&w=2
   
Ok, we need to find some workaround at least for 2.4.x as this
is the compiler most people on sparc64 are using.

I'll play with it a bit...
