Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbUK2L52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbUK2L52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 06:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbUK2L52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 06:57:28 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:31108 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261691AbUK2L5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 06:57:18 -0500
Date: Mon, 29 Nov 2004 13:00:42 +0100
From: DervishD <lkml@dervishd.net>
To: Umar Draz <kernel_org@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help me about (char-major-156)
Message-ID: <20041129120042.GA496@DervishD>
Mail-Followup-To: Umar Draz <kernel_org@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <BAY16-F3064511A9F34D33BE3626AF1BD0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BAY16-F3064511A9F34D33BE3626AF1BD0@phx.gbl>
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

    Hi Umar :)

 * Umar Draz <kernel_org@hotmail.com> dixit:
> i see my /var/log/messages there is 2 lines
> modprobe: Can't locate module char-major-154
> modprobe: Can't locate module char-major-156

    Seems you are lacking an 'alias' entry for a Specialix RIO card,
which is VERY strange :???

    If your old kernel works then the problem is probably in the
configuration of your new kernel.

    What did you exactly to configure your new kernel?

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
