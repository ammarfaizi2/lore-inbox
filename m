Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277720AbRJ1Fpy>; Sun, 28 Oct 2001 01:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277723AbRJ1Fpo>; Sun, 28 Oct 2001 01:45:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13442 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277720AbRJ1Fpe>;
	Sun, 28 Oct 2001 01:45:34 -0400
Date: Sat, 27 Oct 2001 22:46:02 -0700 (PDT)
Message-Id: <20011027.224602.74750641.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: miles@megapathdsl.net, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: What is standing in the way of opening the 2.5 tree?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BDB91D7.C7975C44@mandrakesoft.com>
In-Reply-To: <1004219488.11749.19.camel@stomata.megapathdsl.net>
	<3BDB91D7.C7975C44@mandrakesoft.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Sun, 28 Oct 2001 01:04:23 -0400
   
   Most likely we are
   (a) waiting for stuff to get merged from Alan's tree, and

For the record, I do not feel comfortable at all with forking
2.4.x over to Alan until all of the non-trivial bits of the
AC patches are merged into Linus's tree.

In particular, the quota stuff, which has sat in Alan's tree forever.
If Linus is ignoring the changes it probably is for a good reason
but it would be nice for him to let Alan know what that reason is :-)

Franks a lot,
David S. Miller
davem@redhat.com
