Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWHPSrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWHPSrj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWHPSrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:47:39 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35469 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750756AbWHPSri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:47:38 -0400
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dirk <noisyb@gmx.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44E3552A.6010705@gmx.net>
References: <44E3552A.6010705@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 20:08:18 +0100
Message-Id: <1155755298.24077.395.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-16 am 19:26 +0200, ysgrifennodd Dirk:
> I have changed a message that didn't clearly tell the user what was goin
> on...

File a gnome/kde/distro bug according whichever pile of garbage you've
got trying to do CD status monitoring and getting it wrong. This isn't a
kernel problem, some idiot user application is asking it continually.

Now there is an argument that the message is debug only but thats
another story.

Alan

