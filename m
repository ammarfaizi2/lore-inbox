Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVFWBWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVFWBWC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVFWBWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:22:01 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:15531 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261215AbVFWBTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:19:10 -0400
Message-ID: <42BA0E0B.3080302@g-house.de>
Date: Thu, 23 Jun 2005 03:19:07 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated git HOWTO for kernel hackers
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds schrieb:
> Gaah. I should do a "git-clone-script" or something that does this, and 
> then you could just do
> 
> 	git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
> 	
> Anybody?

hm, isn't cogito doing this already?
(line wraps!)

% cg-clone \
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
linux-2.6

..is doing the same....not?


thanks,
Christian.
-- 
BOFH excuse #118:

the router thinks its a printer.
