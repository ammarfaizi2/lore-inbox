Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318021AbSGRGfr>; Thu, 18 Jul 2002 02:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318022AbSGRGfr>; Thu, 18 Jul 2002 02:35:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43239 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318021AbSGRGfq>;
	Thu, 18 Jul 2002 02:35:46 -0400
Date: Wed, 17 Jul 2002 23:28:32 -0700 (PDT)
Message-Id: <20020717.232832.44968023.davem@redhat.com>
To: hpa@zytor.com
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, viro@math.psu.edu,
       trond.myklebust@fys.uio.no, mnalis-umsdos@voyager.hr, aia21@cantab.net,
       al@alarsen.net, asun@cobaltnet.com, bfennema@falcon.csc.calpoly.edu,
       dave@trylinux.com, braam@clusterfs.com, chaffee@cs.berkeley.edu,
       dwmw2@infradead.org, eric@andante.org, hch@infradead.org,
       jaharkes@cs.cmu.edu, jakub@redhat.com, jffs-dev@axis.com,
       mikulas@artax.karlin.mff.cuni.cz, quinlan@transmeta.com,
       reiserfs-dev@namesys.com, mason@suse.com, rgooch@atnf.csiro.au,
       rmk@arm.linux.org.uk, shaggy@austin.ibm.com, tigran@veritas.com,
       urban@teststation.com, vandrove@vc.cvut.cz, vl@kki.org,
       zippel@linux-m68k.org, ahaas@neosoft.com
Subject: Re: Remain Calm: Designated initializer patches for 2.5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D366103.8010403@zytor.com>
References: <20020718032331.5A36644A8@lists.samba.org>
	<3D366103.8010403@zytor.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "H. Peter Anvin" <hpa@zytor.com>
   Date: Wed, 17 Jul 2002 23:32:35 -0700
   
   As far as I could tell, *ALL* of these changes broke text alignment in 
   columns.  It would have been a lot better if they had maintained 
   spacing; I find the new code much more cluttered and hard to read.

I have to admit that I hate the new syntax too.  The GCC syntax is
so much nicer.
