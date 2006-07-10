Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWGJE4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWGJE4E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 00:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWGJE4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 00:56:04 -0400
Received: from mail.gmx.net ([213.165.64.21]:34782 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751335AbWGJE4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 00:56:02 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.18-rc1-mm1:  /sys/class/net/ethN becoming symlink
	befuddled /sbin/ifup
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060709135148.60561e69.akpm@osdl.org>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	 <1152469329.9254.15.camel@Homer.TheSimpsons.net>
	 <20060709135148.60561e69.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 07:01:38 +0200
Message-Id: <1152507698.8710.2.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-09 at 13:51 -0700, Andrew Morton wrote:

> I'd be suspecting
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/broken-out/gregkh-driver-network-class_device-to-device.patch.

Yeah, that and gregkh-driver-class_device_rename-remove.patch brought it
back to reality.

	-Mike

