Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267543AbTAXE32>; Thu, 23 Jan 2003 23:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267542AbTAXE32>; Thu, 23 Jan 2003 23:29:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23271 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267541AbTAXE31>;
	Thu, 23 Jan 2003 23:29:27 -0500
Date: Thu, 23 Jan 2003 20:27:27 -0800 (PST)
Message-Id: <20030123.202727.102788332.davem@redhat.com>
To: gibbs@scsiguy.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
       marcelo@conectiva.com.br
Subject: Re: Aic7xxx 6.2.28 and Aic79xx 1.3.0 Released
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <739810000.1043382396@aslan.scsiguy.com>
References: <694670000.1043380598@aslan.scsiguy.com>
	<20030123.195327.107011605.davem@redhat.com>
	<739810000.1043382396@aslan.scsiguy.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
   Date: Thu, 23 Jan 2003 21:26:36 -0700

   > Because it is your duty as maintainer to watch what changes
   > (especially build fixes) go into Linus's and Marcelo's tree.
   
   That's like saying that its Linus's or Marcelo's responsibility
   to catch whether you or anyone else submits a bogus/broken change
   to their tree.

Your driver update broke the build of Linus's tree, so I sent Linus
a change that fixed the build.

And in fact, you are describing exactly what Linus and Marcelo's
jobs are, to reject bogus/broken changes.
