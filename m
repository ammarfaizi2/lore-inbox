Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289880AbSCKTci>; Mon, 11 Mar 2002 14:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSCKTc3>; Mon, 11 Mar 2002 14:32:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33293 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289880AbSCKTcS>; Mon, 11 Mar 2002 14:32:18 -0500
Subject: Re: [PATCH] 2.5.6 IDE 19, return of taskfile
To: gunther.mayer@gmx.net (Gunther Mayer)
Date: Mon, 11 Mar 2002 19:47:14 +0000 (GMT)
Cc: andre@linuxdiskcert.org (Andre Hedrick),
        dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3C8CFF64.1B55CDBB@gmx.net> from "Gunther Mayer" at Mar 11, 2002 08:03:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kVlK-0001VU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Currently your taskfile access is hardcoded in tables in your ide patches and this is
> 
> inflexible (e.g. cannot support future commands, unknown at the time of your writing)
> !

It stops things like disk level DRM nicely too
