Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132563AbRDULpj>; Sat, 21 Apr 2001 07:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132564AbRDULp3>; Sat, 21 Apr 2001 07:45:29 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:39949 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S132563AbRDULp0>; Sat, 21 Apr 2001 07:45:26 -0400
Date: Sat, 21 Apr 2001 13:44:35 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: <lk@aniela.eu.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: A question about MMX.
In-Reply-To: <Pine.LNX.4.21.0104211353450.14048-100000@ns1.aniela.eu.org>
Message-ID: <Pine.LNX.4.33.0104211343130.1027-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001 lk@aniela.eu.org wrote:

> I have a Intel Pentium MMX machine and it acts as a mailserver, webserver,
> ftp and I use X on it. I would like to know if the MMX instructions are
> used by the kernel in this operations or not (networking, X etc.).

I _think_ some MMX is used if you configure the kernel for an
MMX-enabled CPU type, but not sure. But as MMX is mainly an extended
floating point instruction set, you will not have much use for it on a
server as you describe.

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] --------------------------------------
[ Cancel Cancelled ]
              - Pine
--------------------------------- [ moffe at amagerkollegiet dot dk ] -

