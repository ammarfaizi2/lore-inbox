Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283567AbRLDW3X>; Tue, 4 Dec 2001 17:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283551AbRLDW3P>; Tue, 4 Dec 2001 17:29:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:12453 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S283535AbRLDW26>;
	Tue, 4 Dec 2001 17:28:58 -0500
Date: Tue, 04 Dec 2001 14:28:42 -0800 (PST)
Message-Id: <20011204.142842.08393744.davem@redhat.com>
To: groudier@free.fr
Cc: kaos@ocs.com.au, hps@intermeta.de, jgarzik@mandrakesoft.com,
        lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011204181546.B2674-100000@gerard>
In-Reply-To: <30026.1007335642@ocs3.intra.ocs.com.au>
	<20011204181546.B2674-100000@gerard>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   
   On Mon, 3 Dec 2001, Keith Owens wrote:
   
   > On Sun, 02 Dec 2001 15:21:57 -0800 (PST),
   > "David S. Miller" <davem@redhat.com> wrote:
   > >   From: Keith Owens <kaos@ocs.com.au>
   > >   Date: Sat, 01 Dec 2001 12:17:03 +1100
   > >
   > >   What is ugly in aic7xxx is :-
   > >
   > >You missed:
   > >
   > >* #undef's "current"
   >
   > Where?  fgrep -ir current 2.4.17-pre2/drivers/scsi/aic7xxx did not find it.

OMFG, it's been fixed... this is amazing.  I am honestly shocked.
