Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSHFTdW>; Tue, 6 Aug 2002 15:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSHFTcn>; Tue, 6 Aug 2002 15:32:43 -0400
Received: from 24.213.60.113.up.mi.chartermi.net ([24.213.60.113]:36835 "EHLO
	back3.chartermi.net") by vger.kernel.org with ESMTP
	id <S315431AbSHFTag>; Tue, 6 Aug 2002 15:30:36 -0400
From: "Russell, Nathaniel" <reddog83@chartermi.net>
Subject: Re: [PATCH] trivial patch for 2.4.20-pre1 8139too.c driver  
 (fwd)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.3.5.3
Date: Tue, 06 Aug 2002 15:28:56 -0400
Message-ID: <web-40244083@back3.chartermi.net>
In-Reply-To: <3D500AF1.9050901@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O K Then 


Russell, Nathaniel wrote:
>My i ask what the sense is to not remove the dead code if
> all we are trying to do is stablize the 2.4x kernel
 series
> and not add extra code or change around the drivers for
> perticular hardware. The code is not used anymore so why
> keep it in the 2.4x series. The code can stay in the 2.5x
> series no problem because there we can change drivers
> rewrite hardware protocalls and tthings like that. 


...because I maintain the driver, and want to keep that
 code around as a note to myself.

	Jeff



