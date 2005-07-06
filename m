Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVGFUTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVGFUTw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVGFUMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:12:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39082 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261898AbVGFTli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 15:41:38 -0400
Date: Wed, 6 Jul 2005 12:41:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Mahoney <jeffm@suse.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       benh@kernel.crashing.org
Subject: Re: [PATCH 2/3 (updated)] openfirmware: add sysfs nodes for open
 firmware devices
In-Reply-To: <20050706192627.GA17492@locomotive.unixthugs.org>
Message-ID: <Pine.LNX.4.58.0507061241010.3570@g5.osdl.org>
References: <20050706192627.GA17492@locomotive.unixthugs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Jul 2005, Jeff Mahoney wrote:
>
>  This patch adds sysfs nodes that the hotplug userspace can use to load the
>  appropriate modules.

Can you re-send the other ones too, and I'll apply the whole series.

Thanks,

		Linus
