Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262637AbVCVLYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbVCVLYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 06:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVCVLYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 06:24:49 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:53733 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262637AbVCVLYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 06:24:31 -0500
Date: Tue, 22 Mar 2005 12:24:57 +0100
From: DervishD <lkml@dervishd.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Voodoo 3 2000 framebuffer problem
Message-ID: <20050322112457.GA55@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050322075116.GC55@DervishD> <20050322090407.GA9084@fargo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050322090407.GA9084@fargo>
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

    Hi David :)

 * David <david@pleyades.net> dixit:
> On Mar 22 at 08:51:16, DervishD wrote:
> >     Linux Kernel 2.4.29, in a do-it-yourself linux box, equipped with
> > an AGP Voodoo 3 2000 card, tdfx framebuffer support. I boot in vga
> > mode 0x0f05, with parameter 'video=tdfx:800x600-32@100' and I get
> > (correctly) 100x37 character grid. All of that is correct. What is
> > not correct is the characters attributes, namely the 'blink'
> > attribute.
> It happens too using the voodoo3 framebuffer driver in 2.6 kernels.
> Specifically i'm using 2.6.10

    Nice :) I've tested under Debian unstable too, and the same
happens (using 2.6.9, IIRC). Thanks for testing :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
