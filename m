Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283691AbRLECRu>; Tue, 4 Dec 2001 21:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283693AbRLECRa>; Tue, 4 Dec 2001 21:17:30 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:34067 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S283691AbRLECRW>; Tue, 4 Dec 2001 21:17:22 -0500
Date: Wed, 5 Dec 2001 03:17:17 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Erik Tews <erik.tews@gmx.net>
cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, <linux-kernel@vger.kernel.org>
Subject: Re: tuning ext2 or ReiserFS to avoid fragmentation with large files?
In-Reply-To: <20011204142047.N11967@no-maam.dyndns.org>
Message-ID: <Pine.LNX.4.33.0112050315450.2930-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2001, Erik Tews wrote:

> If I remember right xfs has got a online-defragmentation utility. So
> have a look at xfs.
> 
> I think xfs works different from reiserfs and ext2 when writing files to
> disk which helps avoiding fragmentation. This feature is called
> allocation groups.

I *might* be wrong, but isn't the allocation-group thing exactly what 
ext2/ext3 does?

I don't know about reiserfs and fragmentation, however.

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] ---------------------------------------
Beware of bugs in the above code;
I have only proved it correct, not tried it.
                              - Donald Knuth
--------------------------------- [ moffe at amagerkollegiet dot dk ] --

