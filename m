Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWCTUFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWCTUFw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 15:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWCTUFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 15:05:52 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:36775 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S1030196AbWCTUFv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 15:05:51 -0500
Date: Mon, 20 Mar 2006 21:05:48 +0100
From: DervishD <lkml@dervishd.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, patrakov@ums.usu.ru
Subject: Re: [PATCH] Fix console utf8 composing (F)
Message-ID: <20060320200548.GB1627@DervishD>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	torvalds@osdl.org, patrakov@ums.usu.ru
References: <Pine.LNX.4.61.0603202048350.14231@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0603202048350.14231@yvahk01.tjqt.qr>
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

    Hi Jan :)

 * Jan Engelhardt <jengelh@linux01.gwdg.de> dixit:
> can we have the patch[2] from this[1] thread merged? I have not yet
> heard back from Alexander since [3]. Plus we're lacking a
> Signed-off-by so far for [2]. What to do?

    Can it be backported to 2.4.x or does it use many 2.6.xisms? I'm
very interested in the issue because otherwise I'm going to add a
terminal emulator for virtual consoles to my vcinit project. I don't
use X and I want to use utf8 in a virtual console...

    Thanks in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
