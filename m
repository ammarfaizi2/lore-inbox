Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVEKPft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVEKPft (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 11:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVEKPfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 11:35:48 -0400
Received: from [83.76.41.205] ([83.76.41.205]:49464 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S261653AbVEKPfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 11:35:36 -0400
Date: Wed, 11 May 2005 17:33:14 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: PC speaker input device
Message-ID: <20050511153314.GA24815@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

PC speaker (CONFIG_INPUT_PCSPKR) is in kernel make menuconfig
2.6.11-gentoo-r5 -> Device Drivers -> Input device support

PC speaker is output device. Why is output device in input device
submenu? Isn't this a mistake?

CL<

