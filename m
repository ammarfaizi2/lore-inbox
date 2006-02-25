Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWBYWqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWBYWqi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWBYWqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:46:38 -0500
Received: from cantor2.suse.de ([195.135.220.15]:5793 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932180AbWBYWqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:46:37 -0500
Date: Sat, 25 Feb 2006 23:46:31 +0100
From: Olaf Hering <olh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
Message-ID: <20060225224631.GA4085@suse.de>
References: <20060225160150.GX3674@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060225160150.GX3674@stusta.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Feb 25, Adrian Bunk wrote:

> CONFIG_UNIX=m doesn't make much sense.

There is likely more code to support a modular unix.ko, this has to go
as well.
