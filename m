Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312854AbSDFWmk>; Sat, 6 Apr 2002 17:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312855AbSDFWmk>; Sat, 6 Apr 2002 17:42:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12562 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312854AbSDFWmj>; Sat, 6 Apr 2002 17:42:39 -0500
Subject: Re: more on 2.4.19pre... & swsusp
To: ed.sweetman@wmich.edu (Ed Sweetman)
Date: Sat, 6 Apr 2002 23:59:16 +0100 (BST)
Cc: brian@worldcontrol.com, linux-kernel@vger.kernel.org
In-Reply-To: <1018127923.4270.60.camel@psuedomode> from "Ed Sweetman" at Apr 06, 2002 04:18:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tz9Q-0002sH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On a different note.  Why doesn't the ac branch have ftpfs yet?  Besides
> the fact that it sometimes has problems with ls'ing a directory because

Because its perfectly doable in user space. Its for testing useful stuff not
a dumping ground
