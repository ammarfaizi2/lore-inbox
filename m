Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbULWMYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbULWMYd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 07:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbULWMYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 07:24:33 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:37009 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261219AbULWMYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 07:24:32 -0500
Subject: Re: [2.6 patch] drivers/char/mxser.c: make some code static (fwd)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041222115012.GQ5217@stusta.de>
References: <20041222115012.GQ5217@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103800715.13188.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 23 Dec 2004 11:18:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-22 at 11:50, Adrian Bunk wrote:
> The patch forwarded below still applies and compiles against 
> 2.6.10-rc3-mm1.
> 
> Please apply.

Merged with the updated mxser.c driver (a clean up of 1.8 from the
vendor) and included in the diff I sent Linus and Russell.

