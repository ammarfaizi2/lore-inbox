Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbULBAo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbULBAo6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 19:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbULBAo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 19:44:58 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:10150 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261521AbULBAo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 19:44:56 -0500
Subject: Re: dma errors with sata_sil and Seagate disk
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Lash <jlash@speakeasy.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041201115045.3ab20e03@homer.sarvega.com>
References: <20041201115045.3ab20e03@homer.sarvega.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101944482.30990.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Dec 2004 23:41:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-01 at 17:50, John Lash wrote:
> I don't see any indication that Seagate has released any public firmware
> upgrades for this drive. Anybody have a suggestion?

Don't mix seagate drives and SI311x hardware is the best suggestion.
Even if you activate the workaround for the problem you take a
performance hit.

Please send Jeff Garzik a patch for the the change you made of course.

