Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbULIU34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbULIU34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 15:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbULIU34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 15:29:56 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:50327 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261608AbULIU3x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 15:29:53 -0500
Date: Thu, 9 Dec 2004 21:29:40 +0100
From: DervishD <lkml@dervishd.net>
To: Junio C Hamano <junkio@cox.net>
Cc: linux-kernel@vger.kernel.org,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: CD-ROM ide-dma blacklist amnesty drive
Message-ID: <20041209202940.GA15661@DervishD>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	linux-kernel@vger.kernel.org,
	"Alexander E. Patrakov" <patrakov@ums.usu.ru>
References: <cp78ct$d65$1@sea.gmane.org> <7v7jns2tu3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7v7jns2tu3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Junio :)

 * Junio C Hamano <junkio@cox.net> dixit:
>     PLEXTOR CD-R PX-W8432T
[...]
> If (1) you are a owner of one of the listed drives, and (2) you
> know your drive works fine with DMA, please speak up.
> It would especially be a big plus if your drive is on via82cxxx
> and did not have any trouble running it with DMA before 2.6.8.

    Well, I happen to had such Plextor drive under a VIA 686B and it
worked good with DMA. At least, DMA was enabled and the drive never
issued a 'DMA disabled' error. This was under 2.4.10. I no longer
have that drive so I cannot make tests under a newer test. The drive
was used with success using both SCSI hostadapter emulation and IDE
driver. I think I have the logs of that time if you are interested.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
