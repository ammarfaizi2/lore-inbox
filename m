Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbVGMMMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbVGMMMD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 08:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVGMMMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 08:12:02 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:58036 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262811AbVGMML5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 08:11:57 -0400
Date: Wed, 13 Jul 2005 14:14:43 +0200
From: DervishD <lkml@dervishd.net>
To: Konstantin Kudin <konstantin_kudin@yahoo.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: fdisk: What do plus signs after "Blocks" mean?
Message-ID: <20050713121443.GC58@DervishD>
Mail-Followup-To: Konstantin Kudin <konstantin_kudin@yahoo.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	linux-kernel@vger.kernel.org
References: <200507122019.j6CKJwxe021850@laptop11.inf.utfsm.cl> <20050712204822.84567.qmail@web52001.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050712204822.84567.qmail@web52001.mail.yahoo.com>
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

    Hi Konstantin :)

 * Konstantin Kudin <konstantin_kudin@yahoo.com> dixit:
>  Actually, it seems like one can backup information on ALL partitions
> by using the command "sfdisk -dx /dev/hdX". Supposedly, it reads not
> only primary but also extended partitions. "sfdisk -x /dev/hdX" should
> be then able to write whatever is known back to the disk.

    Cool! A long time has passed since I used sfdisk, but I used it
for manually re-reading partition tables and the like :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
