Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbUK1Qzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUK1Qzs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbUK1QzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:55:23 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:56262 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261533AbUK1QyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:54:08 -0500
Message-ID: <41AA02AC.3070200@suse.de>
Date: Sun, 28 Nov 2004 17:54:04 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041104)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsusp kconfig: Change in wording (fwd)
References: <20041126113040.GB1028@elf.ucw.cz>
In-Reply-To: <20041126113040.GB1028@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>           Right now you may boot without resuming and then later resume but
>           in meantime you cannot use those swap partitions/files which were

Is this still true? Don't we kill the image early, even with "noresume"?
It is of course possible by omitting the "resume=" parameter, but not
for the faint of heart ;-)

   Stefan
