Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbRESQbH>; Sat, 19 May 2001 12:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261860AbRESQa5>; Sat, 19 May 2001 12:30:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15876 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261858AbRESQao>; Sat, 19 May 2001 12:30:44 -0400
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
To: bcrl@redhat.com (Ben LaHaise)
Date: Sat, 19 May 2001 17:25:22 +0100 (BST)
Cc: viro@math.psu.edu (Alexander Viro), andrewm@uow.edu.au (Andrew Morton),
        Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105191153400.5829-100000@devserv.devel.redhat.com> from "Ben LaHaise" at May 19, 2001 11:56:26 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1519Xe-00005c-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now that I'm awake and refreshed, yeah, that's awful.  But
> echo "hot-add,slot=5,device=/dev/sda" >/dev/md0/control *is* sane.  Heck,
> the system can even send back result codes that way.

Only to an English speaker. I suspect Quebec City canadians would prefer a
different command set.
