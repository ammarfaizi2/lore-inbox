Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135940AbREBVOb>; Wed, 2 May 2001 17:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135977AbREBVOU>; Wed, 2 May 2001 17:14:20 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:12805 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S135940AbREBVNN>; Wed, 2 May 2001 17:13:13 -0400
Date: Wed, 2 May 2001 23:12:55 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: >2G Files
In-Reply-To: <20010502145718.A24262@ganymede.isdn.uiuc.edu>
Message-ID: <Pine.LNX.4.33.0105022311460.7169-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2001, Bill Wendling wrote:

> Question: Does Linux support >2G files and, if so, how do I implement
> this?

With kernel 2.4 it does. You will probably need to compile
userspace programs against 2.4 headers to get this functionality in
userspace programs too.

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] --------------------------------------
I think the sum of intelligence on the internet is constant.
Only the number of users grows.
                                 - Uwe Ohse in the monastery
--------------------------------- [ moffe at amagerkollegiet dot dk ] -

