Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264050AbTE0Sbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbTE0Sbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:31:47 -0400
Received: from h2.prohosting.com.ua ([217.106.231.81]:461 "EHLO
	h2.prohosting.com.ua") by vger.kernel.org with ESMTP
	id S264050AbTE0Sbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:31:41 -0400
From: Artemio <artemio@artemio.net>
To: linux-kernel@vger.kernel.org
Subject: Re: HELP: No framebuffer option in config
Date: Tue, 27 May 2003 21:40:04 +0300
User-Agent: KMail/1.5
References: <200305272130.50993.artemio@artemio.net> <200305272041.44518.m.c.p@wolk-project.de>
In-Reply-To: <200305272041.44518.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305272139.31315.artemio@artemio.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - h2.prohosting.com.ua
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - artemio.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> please do this:
>
> 1. make menuconfig
> 2. Code maturity level options  --->
> 3. [*] Prompt for development and/or incomplete code/drivers
>
> after selecting 3rd, you should see it in: "Console drivers"

THANKS!

Man, I should have guessed...

Good luck!

Artemio.
