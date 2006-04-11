Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWDKS6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWDKS6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 14:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWDKS6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 14:58:55 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:7613 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750998AbWDKS6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 14:58:55 -0400
Date: Tue, 11 Apr 2006 20:58:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ramakanth Gunuganti <rgunugan@yahoo.com>
cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL issues
In-Reply-To: <20060411154944.65714.qmail@web54308.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0604112055380.25940@yvahk01.tjqt.qr>
References: <20060411154944.65714.qmail@web54308.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Since it's the Linux kernel that's under GPLv2, any
>work done here should be released under GPLv2. That
>part seems to be clear, however any product would
>include other things that could be proprietary.

One thing that is clear in the GPL: If you link the kernel with something 
else to an executable, the resulting blob (and therefore the sources to the 
proprietary part) must be GPL.

Linking by making certain parts shared libraries is already a gray zone.

If in doubt, release everything. It also offers users the possibility to 
find your bugs.


Jan Engelhardt
-- 
