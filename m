Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVAaTF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVAaTF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVAaTF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:05:26 -0500
Received: from mail.suse.de ([195.135.220.2]:3989 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261315AbVAaTFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:05:23 -0500
Date: Mon, 31 Jan 2005 20:05:22 +0100
From: Olaf Hering <olh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/char/tty_io.c: remove console_use_vt
Message-ID: <20050131190522.GA17096@suse.de>
References: <20050131174105.GW18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050131174105.GW18316@stusta.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Jan 31, Adrian Bunk wrote:

> The global variable console_use_vt never changed its' value.

I think that comes from xen.

