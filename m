Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270165AbRHMMj4>; Mon, 13 Aug 2001 08:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270168AbRHMMjq>; Mon, 13 Aug 2001 08:39:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33028 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270165AbRHMMji>; Mon, 13 Aug 2001 08:39:38 -0400
Subject: Re: VM working much better in 2.4.8 than before
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Mon, 13 Aug 2001 13:41:12 +0100 (BST)
Cc: helgehaf@idb.hist.no (Helge Hafting), linux-kernel@vger.kernel.org
In-Reply-To: <20010813104900Z16329-1231+665@humbolt.nl.linux.org> from "Daniel Phillips" at Aug 13, 2001 12:55:12 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WH1s-0007Jw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, those would be the expected effects of use-once, in fact it was
> "morning after updatedb" question that got me started on it.

updatedb is also absolutely fine if you just work with the existing VM
and up the inode pressure a little. I'm still very unconvinced by use-once.

Alan
