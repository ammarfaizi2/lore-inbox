Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285747AbSBKAu1>; Sun, 10 Feb 2002 19:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285829AbSBKAuS>; Sun, 10 Feb 2002 19:50:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14088 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285747AbSBKAuI>; Sun, 10 Feb 2002 19:50:08 -0500
Subject: Re: 2.4.18-pre8-K2: Kernel panic: CPU context corrupt
To: davej@suse.de (Dave Jones)
Date: Mon, 11 Feb 2002 01:03:23 +0000 (GMT)
Cc: pavel@suse.cz (Pavel Machek), fork0@users.sourceforge.net (Alex Riesen),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.33.0202102232510.29486-100000@Appserv.suse.de> from "Dave Jones" at Feb 10, 2002 10:33:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16a4sN-0004yi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Maybe you should print something like
> > Machine Check Exception: .... (hardware problem!)
> > so that we get less reports like this?
> 
> When I get around to finishing the diagnosis tool, I'll add
> something like "Feed to decodemca for more info".

For a lot of processors the MCE values are not documented. Strangely for
once Intel are the good guys and AMD seem to be sitting on the docs.

