Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030674AbWAKB7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030674AbWAKB7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030705AbWAKB7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:59:11 -0500
Received: from [81.2.110.250] ([81.2.110.250]:25476 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030674AbWAKB7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:59:09 -0500
Subject: Re: [2.6 patch] drivers/net/{,wireless/}Kconfig: remove dead URL
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200601110153.21989.ak@suse.de>
References: <20060111003747.GJ3911@stusta.de>
	 <1136940409.3435.126.camel@localhost.localdomain>
	 <200601110153.21989.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Jan 2006 01:58:58 +0000
Message-Id: <1136944738.28616.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-01-11 at 01:53 +0100, Andi Kleen wrote:
> shaper is completely obsolete and it's probably best to just remove
> all references to it and the kernel driver too.

I would agree with that but it nees to go through a proper obsolesence
and obliteration cycle not just vanish.

