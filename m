Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289334AbSA1TSd>; Mon, 28 Jan 2002 14:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289338AbSA1TSY>; Mon, 28 Jan 2002 14:18:24 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:52363 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S289334AbSA1TSM>; Mon, 28 Jan 2002 14:18:12 -0500
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Why 'linux/fs.h' cannot be included? I *can*...
Message-Id: <E16VHV3-0001Wh-00@DervishD.viadomus.com>
Date: Mon, 28 Jan 2002 20:31:29 +0100
From: DervishD <raul@viadomus.com>
Reply-To: DervishD <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello all :))

    I've reading the source code for 'blockdev', from util-linux, and
the comments says that the header 'linux/fs.h' cannot be included.
I've tried, just adding an include and removing the hand made
definitions (cloning those of fs.h), and all works ok :??

    This header can be included or not? It works for me, with headers
from 2.4.17, so, is it just for backwards compatibility?

    Thanks a lot in advance :)
    Raúl
