Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284853AbRLPVuk>; Sun, 16 Dec 2001 16:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284855AbRLPVub>; Sun, 16 Dec 2001 16:50:31 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:19584 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S284853AbRLPVuV>; Sun, 16 Dec 2001 16:50:21 -0500
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Is /dev/shm needed?
Message-Id: <E16FjME-0000WW-00@DervishD.viadomus.com>
Date: Sun, 16 Dec 2001 23:02:06 +0100
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <raul@viadomus.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello all :))

    I don't know if /dev/shm (mounted with shmfs or the newer tmpfs)
is needed for proper SYSV IPC operation with newer (2.4.16 and newer)
kernel. Anyone can help?

    Moreover: I want to move my /tmp from disk to tmpfs for speed (I
make a lot of compiling, so I think it would help). Is this a good
idea? If so, what size can be appropriate for a small system that is
not permanently running?

    Thanks a lot for the answers :))

    Raúl
