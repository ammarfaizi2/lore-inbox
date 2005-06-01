Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVFAKIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVFAKIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 06:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVFAKIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 06:08:20 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:15598 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261172AbVFAKIO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 06:08:14 -0400
Date: Wed, 1 Jun 2005 12:10:22 +0200
From: DervishD <lkml@dervishd.net>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Parallel Port: Settings PINs on?
Message-ID: <20050601101022.GE3690@DervishD>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
References: <20050601100150.GB27717@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050601100150.GB27717@schottelius.org>
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

    Hi Nico :)

 * Nico Schottelius <nico-kernel@schottelius.org> dixit:
> Is it possible to select (in userspace) which pins
> should be enabled or do I have to write a kernel driver
> for that?

    Userspace will do. Take a look at programs like 'parapin', 'k74',
'libieee1284', 'libparportled', or similars. Look in FreshMeat. As
far as I know, all them runs in userspace, although you can find some
Linux drivers for performing pin control of parallel port.
 
    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
