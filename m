Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSFFQ5E>; Thu, 6 Jun 2002 12:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317013AbSFFQ5D>; Thu, 6 Jun 2002 12:57:03 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:41478 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S317012AbSFFQ5C> convert rfc822-to-8bit; Thu, 6 Jun 2002 12:57:02 -0400
Date: Thu, 6 Jun 2002 18:57:02 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
X-X-Sender: moffe@grignard
To: Francois Romieu <romieu@cogenit.fr>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Failure report: tulip driver
In-Reply-To: <20020604201812.A20250@fafner.intra.cogenit.fr>
Message-ID: <Pine.LNX.4.44.0206061853100.1178-100000@grignard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2002, Francois Romieu wrote:

> moffe@amagerkollegiet.dk :
> [...]
> > Gnu C                  2.95.2
>
> It won't hurt if you upgrade. It may if you don't.

It is the standard Debian potato gcc package; I assumed they had
committed fixes to gcc.

I *could* compile one with gcc 2.95.4 (debian woody) or 2.96 (redhat
7.0+updates) and wait for the problem to happen again (it does not
happen often, but often enough to be annoying). However searching on
google, tells me that many others have like problems, and it does not
seem to be compiler-related.

/Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
I'm a unix system administrator
- sending me HTML formatted emails and/or attached Word documents is a
nice way to ensure I won't bother to answer you.
                                                     -- Jan Chrillesen
----------------------------------[ moffe at amagerkollegiet dot dk ] --

