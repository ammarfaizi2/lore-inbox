Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292367AbSBYWfp>; Mon, 25 Feb 2002 17:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292370AbSBYWfi>; Mon, 25 Feb 2002 17:35:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27141 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292367AbSBYWfR>; Mon, 25 Feb 2002 17:35:17 -0500
Subject: Re: Linux 2.4.18 - Full tarball is OK
To: riel@conectiva.com.br (Rik van Riel)
Date: Mon, 25 Feb 2002 22:49:33 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        chris@directcommunications.net (Chris Funderburg),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0202251931360.7820-100000@imladris.surriel.com> from "Rik van Riel" at Feb 25, 2002 07:32:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fTw5-0006a7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If so Marcelo can you put up 2.4.18-fixed patch and a borked-fixed diff ?
> 
> That would break hpa's incremental diff patches.
> If somebody needs 2.4.18 + fix, they can just run 2.4.18-rc4.

That isnt the problem. Is 2.4.19-pre1 a patch versus the 2.4.18 tarball
or the 2.4.18 patch ? Continue ad infinitum through every 2.4 release,
add hundreds of confused emails about them to the kernel list and it ceases
to look a smart idea to leave the two not matching

Alan

