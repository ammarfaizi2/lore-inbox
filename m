Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129190AbRCBOZm>; Fri, 2 Mar 2001 09:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129191AbRCBOZd>; Fri, 2 Mar 2001 09:25:33 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26629 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129190AbRCBOZX>; Fri, 2 Mar 2001 09:25:23 -0500
Subject: Re: 2.4.2ac8 lost char devices
To: jamagallon@able.es (J . A . Magallon)
Date: Fri, 2 Mar 2001 14:08:13 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <20010302030946.A2631@werewolf.able.es> from "J . A . Magallon" at Mar 02, 2001 03:09:46 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YqEC-0001c7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, somethig has broken in ac8, because I lost my PS/2 mouse and
> (less important, but perhaps it is useful) the microcode driver. So
> I think it something common to both.

Someone broke all the misc devices.  Patch coming in ac9 RSN

