Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262828AbSLFOPr>; Fri, 6 Dec 2002 09:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbSLFOPq>; Fri, 6 Dec 2002 09:15:46 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:35025 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP
	id <S262828AbSLFOPq>; Fri, 6 Dec 2002 09:15:46 -0500
Date: Fri, 6 Dec 2002 15:23:22 +0100 (CET)
From: Martin Kacer <M.Kacer@sh.cvut.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: bttv: Strange frame drop-outs during TV grabbing
In-Reply-To: <20021204234501.GA163@elf.ucw.cz>
Message-ID: <Pine.LNX.4.21.0212061522010.22957-100000@nightmare.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2002, Pavel Machek wrote:
# > 5) The regular period is retained when I quit the MEncoder and run it
# > again. I.e., it happens every 55 seconds of REAL time, even if the new
# > MEncoder instance is run. This is why I think it is NOT the MEncoder
# > issue!
# ext3? 55 sounds like journal flush interval..

   Thanks for the tip but I still use ext2fs.
   Moreover, under 2.5.50, the interval is twice as long (over 100 sec).
   - M -

