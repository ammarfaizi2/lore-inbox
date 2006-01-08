Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932725AbWAHM3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbWAHM3K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 07:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbWAHM3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 07:29:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19397 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752610AbWAHM3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 07:29:09 -0500
Date: Sun, 8 Jan 2006 04:28:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
Message-Id: <20060108042855.183c35cc.akpm@osdl.org>
In-Reply-To: <43C050FA.9040400@ens-lyon.org>
References: <20060107052221.61d0b600.akpm@osdl.org>
	<43C0172E.7040607@ens-lyon.org>
	<20060107145800.113d7de5.akpm@osdl.org>
	<43C050FA.9040400@ens-lyon.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>
>  >> 3) wpa_supplicant does not find my WPA network anymore (while iwlist
>  >> scanning sees). I didn't see anything relevant in dmesg. My driver is
>  >> ipw2200.

And this one I don't have a clue about.  Can you test the next git
snapshot, or otherwise work out a bit more about it?
