Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281165AbRL0Lwp>; Thu, 27 Dec 2001 06:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286251AbRL0Lwf>; Thu, 27 Dec 2001 06:52:35 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:5504 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S281165AbRL0LwZ>; Thu, 27 Dec 2001 06:52:25 -0500
To: hholzer@may.co.at, linux-kernel@vger.kernel.org
Subject: Re: Out of Memory at 20GB of free memory ??
Message-Id: <E16JZGx-0000Lc-00@DervishD.viadomus.com>
Date: Thu, 27 Dec 2001 13:04:31 +0100
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <raul@viadomus.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

>/proc/meminfo after the first process kill:
>        total:    used:    free:  shared: buffers:  cached:
>Mem:  33815060480 13490249728 20324810752        0 15745024 13089452032

    This leads to a suggestion... How about aligning the top
indication with the numbers below (or even better, putting them in
different lines ;)))

    Even with more than 99MB of RAM (quite usual these days), the top
line is misaligned and a little bit confusing.

    I can make the necessary patch if anyone is interested.

    Raúl
