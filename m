Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277541AbRJKAIG>; Wed, 10 Oct 2001 20:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277551AbRJKAH4>; Wed, 10 Oct 2001 20:07:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39815 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277549AbRJKAHt>;
	Wed, 10 Oct 2001 20:07:49 -0400
Date: Wed, 10 Oct 2001 17:08:05 -0700 (PDT)
Message-Id: <20011010.170805.35468036.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: rudi@sluijtman.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] .version, newversion in Makefile
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011011010032.H17670@flint.arm.linux.org.uk>
In-Reply-To: <200110102122.f9ALMx424058@nerys.ehv.lx>
	<20011011010032.H17670@flint.arm.linux.org.uk>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Thu, 11 Oct 2001 01:00:32 +0100

   On Wed, Oct 10, 2001 at 11:22:59PM +0200, Rudi Sluijtman wrote:
   > Due to a change in the main Makefile the .version file is overwritten
   > by a new empty one since at least 2.4.10-pre12, so the version becomes
   > or remains 1 after each recompile.
   
   There is a patch in -ac to fix this.
   
I've also independantly just sent Linus a patch to fix this.
I was not aware of the -ac fix, sorry.

Franks a lot,
David S. Miller
davem@redhat.com
