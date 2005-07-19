Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVGSQWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVGSQWJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 12:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVGSQWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 12:22:08 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:46506 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261528AbVGSQVV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 12:21:21 -0400
Date: Tue, 19 Jul 2005 18:24:25 +0200
From: DervishD <lkml@dervishd.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: USB debouncing?
Message-ID: <20050719162425.GA135@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

    Hi all :)

    I have a new MP3 player, and when I disconnect it from the USB
port, my logs says:

    <30>Jul 19 18:11:05 kernel: usb.c: USB disconnect on device 00:07.3-1 address 2
    <27>Jul 19 18:11:06 kernel: hub.c: connect-debounce failed, port 1 disabled

    What is that 'connect-debounce' for? Is the port damaged? Am I
doing anything wrong?

    Thanks a lot in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
