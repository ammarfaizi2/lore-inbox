Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314571AbSEVO3j>; Wed, 22 May 2002 10:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314596AbSEVO3i>; Wed, 22 May 2002 10:29:38 -0400
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:52623 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314571AbSEVO3h>; Wed, 22 May 2002 10:29:37 -0400
Date: Wed, 22 May 2002 15:29:37 +0100 (BST)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: alastair@gerber
To: linux-kernel@vger.kernel.org
Subject: Re: Have the 2.4 kernel memory management problems on large machines
 been fixed?
Message-ID: <Pine.GSO.4.44.0205221524130.1550-100000@gerber>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ... Linus is not applying them

Shouldn't that be "Marcelo is not applying them"?  Linus has devolved
all responsibility for 2.4 now, and is concentrating on the 2.5 series
and all its radical changes.

Marcelo objected to Andrea's mega-patch, but if I recall, he hinted that
me might start merging the split-up patches for 2.4.20 - in the
meantime, you can always apply the latest -aa patch yourself to a
2.4.19-pre kernel. Otherwise, the Red Hat patched kernel (which I
believe still doesn't use Andrea's VM at all) ought to work well, with
all their spiffy regression testing etc....

Cheers
Alastair

o o o o o o o o o o o o o o o o o o o o o o o o o o o o
Alastair Stevens           \ \
MRC Biostatistics Unit      \ \___________ 01223 330383
Cambridge UK                 \___ www.mrc-bsu.cam.ac.uk

