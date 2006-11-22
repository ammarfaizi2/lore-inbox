Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753888AbWKVOxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbWKVOxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 09:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754301AbWKVOxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 09:53:23 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:5868 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1753888AbWKVOxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 09:53:22 -0500
Date: Wed, 22 Nov 2006 15:53:44 +0100
From: DervishD <lkml@dervishd.net>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       The Peach <smartart@tiscali.it>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: bug? VFAT copy problem
Message-ID: <20061122145344.GB18141@DervishD>
Mail-Followup-To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	The Peach <smartart@tiscali.it>, linux-kernel@vger.kernel.org
References: <20061120164209.04417252@localhost> <877ixqhvlw.fsf@duaron.myhome.or.jp> <20061120184912.5e1b1cac@localhost> <87mz6kajks.fsf@duaron.myhome.or.jp> <1164204175.10427.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1164204175.10427.1.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
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

    Hi Sérgio :)

 * Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> dixit:
> Have vfat a limit of a file size when copy ? 

    2GB, if I recall correctly. FAT32 itself has a limit of 4GB-1 for
file size, but Linux restricts it even more (don't ask me why).

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!
