Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315689AbSEIKaG>; Thu, 9 May 2002 06:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSEIKaF>; Thu, 9 May 2002 06:30:05 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:12928 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S315689AbSEIKaC>; Thu, 9 May 2002 06:30:02 -0400
Date: Thu, 09 May 2002 12:34:54 +0200
Organization: ViaDomus
To: npy@mailhost.net, linux-kernel@vger.kernel.org
Subject: Re: Slow harddisk
Cc: npy@mailhost.net
Message-ID: <3CDA50CE.mail6SA113L7B@viadomus.com>
In-Reply-To: <Pine.LNX.4.33.0205091822350.2853-100000@lal.cablix.com>
User-Agent: nail 9.29 12/10/01
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@viadomus.com>
Reply-To: DervishD <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi, Ng :))

> I/O support  =  3 (32-bit w/sync)

    Try w/o sync

> using_dma    =  0 (off)

    Enable dma

    This should increase the speed to normal levels.

    Raúl
