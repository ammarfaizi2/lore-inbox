Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbUKXOJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbUKXOJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbUKXOHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:07:11 -0500
Received: from zeus.kernel.org ([204.152.189.113]:35277 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262718AbUKXNkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:40:16 -0500
Date: Wed, 24 Nov 2004 12:38:38 +0100
From: DervishD <lkml@dervishd.net>
To: Pavel Fedin <sonic_amiga@rambler.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Licensing question
Message-ID: <20041124113838.GB30870@DervishD>
Mail-Followup-To: Pavel Fedin <sonic_amiga@rambler.ru>,
	linux-kernel@vger.kernel.org
References: <20041124140433.1d9d1022.sonic_amiga@rambler.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041124140433.1d9d1022.sonic_amiga@rambler.ru>
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

    Hi Pavel :)

 * Pavel Fedin <sonic_amiga@rambler.ru> dixit:
>  Currently i use a little part of ide-cd driver and its includes.

    I'm not a lawyer, and I'm not a GPL-expert, neither, but AFAIK,
if you use GPL code in your project, your code becomes GPLd too.

    If you use ide-cd driver (or even a part of it), since it is GPL,
the code that uses it is GPL too. If Aros is not going to distribute
such source code, then Aros is not allowed to use GPL code.

    Ask FSF for details.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
