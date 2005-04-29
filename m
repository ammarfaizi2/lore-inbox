Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVD2LVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVD2LVi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 07:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVD2LVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 07:21:38 -0400
Received: from 213-146-165-184.kunde.vdserver.de ([213.146.165.184]:50958 "EHLO
	old-fsckful.ath.cx") by vger.kernel.org with ESMTP id S262308AbVD2LVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 07:21:34 -0400
Message-ID: <36804.62.178.6.202.1114773674.squirrel@webmail.snikt.net>
In-Reply-To: <20050428210331.GA12597@elf.ucw.cz>
References: <slrnd6v9ir.b61.news_0403@localhost.localdomain>
    <20050428210331.GA12597@elf.ucw.cz>
Date: Fri, 29 Apr 2005 13:21:14 +0200 (CEST)
Subject: Re: system reboot after reading /proc/acpi/battery/../state
From: crow@old-fsckful.ath.cx
To: "Pavel Machek" <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi!
Hi!

> Add printks to see where it reboots... it may be faster than binary
> searching acpi updates.

seems like disabling tco watchdog took care of this problem..

thanks,
Andreas
