Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbRFBKxO>; Sat, 2 Jun 2001 06:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262515AbRFBKxE>; Sat, 2 Jun 2001 06:53:04 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:56069 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S262500AbRFBKwt>; Sat, 2 Jun 2001 06:52:49 -0400
Date: Sat, 2 Jun 2001 12:52:46 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Andreas Hartmann <andihartmann@freenet.de>
cc: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.5 and all ac-Patches] massive file corruption with reiser
 or NFS
In-Reply-To: <01060211530400.00350@athlon>
Message-ID: <Pine.LNX.4.33L2.0106021251570.1083-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Jun 2001, Andreas Hartmann wrote:

> I got massive file corruptions with the kernels mentioned in the subject. I
> can reproduce it every time.

You cannot use NFS on reiserfs unless you apply the knfsd patch. Look at
www.namesys.com.

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] --------------------------------------
If you only have a hammer
everything looks like a nail
-------------------------------- [ moffe at amagerkollegiet dot dk ] --0

