Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbVDGMeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVDGMeD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 08:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVDGMeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 08:34:03 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:9709 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262446AbVDGMd1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 08:33:27 -0400
Date: Thu, 7 Apr 2005 14:34:07 +0200
From: DervishD <lkml@dervishd.net>
To: Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: find: /usr/src/linux-2.4.30/include/asm: Too many levels of symbolic links
Message-ID: <20050407123407.GF12342@DervishD>
Mail-Followup-To: Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>,
	LKML <linux-kernel@vger.kernel.org>
References: <4255252D.4050708@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4255252D.4050708@ribosome.natur.cuni.cz>
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

    Hi Martin :)

 * Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz> dixit:
>  again I've hit some wird problem doing "make dep" for 2.4 kernel:

    Not a kernel problem but a findutils problem. Fixed in 4.2.19,
but 4.2.20 was released recently. Upgrade.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
