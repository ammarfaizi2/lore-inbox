Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129813AbRCCWSH>; Sat, 3 Mar 2001 17:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129814AbRCCWR6>; Sat, 3 Mar 2001 17:17:58 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12812 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129813AbRCCWRl>; Sat, 3 Mar 2001 17:17:41 -0500
Subject: Re: [BUG] 2.4.x system Freezes
To: tomlins@cam.org (Ed Tomlinson)
Date: Sat, 3 Mar 2001 22:20:42 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <01030316312900.00689@oscar> from "Ed Tomlinson" at Mar 03, 2001 04:31:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ZKOK-0004DI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> able to get into kdb from a serial console (an then lost the log - murphy can 
> be a real PITA).   I figure a ps, bt and bta should be enough to point out 
> the problem task?  Its there anything else I should do (sr t maybe?)?

That should give you most of the info
