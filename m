Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131236AbRCWQnk>; Fri, 23 Mar 2001 11:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131237AbRCWQn3>; Fri, 23 Mar 2001 11:43:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59150 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131236AbRCWQnJ>; Fri, 23 Mar 2001 11:43:09 -0500
Subject: Re: raw access and qlogic isp device driver?
To: joel@tux.org (Joel Gallun)
Date: Fri, 23 Mar 2001 16:45:08 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0103231129060.6117-100000@gwyn.tux.org> from "Joel Gallun" at Mar 23, 2001 11:33:27 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gUgZ-00050U-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm trying to use Stephen Tweedie's raw device support to access disks
> attached to a Qlogic ISP 1040/B controller and kernel oopses.

2.2 or 2.4 ?

> Has anyone used the raw device with qlogicisp driver? Does anyone have any
> interest in looking at this?

It shouldnt matter which driver is involved, but 2.4 raw stuff is reported
broken still

