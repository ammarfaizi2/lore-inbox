Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274877AbRIVASH>; Fri, 21 Sep 2001 20:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274878AbRIVAR5>; Fri, 21 Sep 2001 20:17:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62985 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274877AbRIVARi>; Fri, 21 Sep 2001 20:17:38 -0400
Subject: Re: [PATCH] 2.4.9-ac13 - parse_options() in reiserfs still broken
To: proski@gnu.org (Pavel Roskin)
Date: Sat, 22 Sep 2001 01:23:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <Pine.LNX.4.33.0109211951010.1373-100000@portland.hansa.lan> from "Pavel Roskin" at Sep 21, 2001 08:10:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kaZT-0001lZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm a bit disappointed that the bug with option parsing in reiserfs wasn't
> fixed in 2.4.9-ac13.  It's a serious issue that prevents mounting
> reiserfs partitions on system startup (except root partition).

Please wait for -ac14. That has the next batch of fixes in from Hans
Namesys guys
