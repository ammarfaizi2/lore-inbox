Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVAIMZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVAIMZc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 07:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVAIMZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 07:25:32 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:62872 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261290AbVAIMZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 07:25:27 -0500
Date: Sun, 9 Jan 2005 13:25:57 +0100
From: DervishD <lkml@dervishd.net>
To: Michal Feix <michal@feix.cz>, linux-kernel@vger.kernel.org
Subject: Re: Conflicts in kernel 2.6 headers and {glibc,Xorg}
Message-ID: <20050109122557.GA221@DervishD>
Mail-Followup-To: Michal Feix <michal@feix.cz>,
	linux-kernel@vger.kernel.org
References: <41E0F76D.7080805@feix.cz> <20050109110805.GA8688@irc.pl> <41E1170D.6090405@feix.cz> <20050109115554.GA9183@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050109115554.GA9183@irc.pl>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi All :)

 * Tomasz Torcz <zdzichu@irc.pl> dixit:
>  Mainstream distributions use ,,sanitized'' version o kernel
> headers - Fedora has own set, Debian has another, LFS too. For rest
> and for us, casual users, there are headers made as byproduct of
> PLD Linux, which are used since december 2003 (before kernel 2.6
> was even released).

    But the set of sanitized kernel headers, if you build your own
software and you're not using a distro, is only available for 2.6.x
kernels, not for 2.4.x kernels. What should be done for 2.4 kernels?
I currently use a set of headers from the 2.4 kernel I used to build
my libc, not the headers from the current kernel I'm running, but I
would like to know anyway.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
