Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbULYVVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbULYVVq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 16:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbULYVVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 16:21:45 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:920 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261569AbULYVVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 16:21:40 -0500
Subject: Re: Intel 810(E) driver in Kernel 2.6.10 - same problem as in 2.6.9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John McGowan <jmcgowan@inch.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041225193400.GA2700@localhost.localdomain>
References: <20041225193400.GA2700@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104005852.23660.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 25 Dec 2004 20:17:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-12-25 at 19:34, John McGowan wrote:
> Intel 810(E) driver in Kernel 2.6.10 - same problem as in 2.6.9
> 
> Fedora Core2; xorg 6.8.1 (and 6.7.x); kernel 2.6.9/2.6.10
>               (other problem in earlier 2.6.x?)
>               Intel i810(E) driver

In my case at least updating the X server packages fixed it.

