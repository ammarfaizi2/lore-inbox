Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265309AbUFRWHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265309AbUFRWHW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264226AbUFRWC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:02:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:40334 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263775AbUFRV7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:59:13 -0400
To: Adrian Almenar <aalmenar@conectium.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysfs directories...
References: <20040618155117.0bffd01d@er-murazor.conectium.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I want another RE-WRITE on my CAESAR SALAD!!
Date: Fri, 18 Jun 2004 23:54:58 +0200
In-Reply-To: <20040618155117.0bffd01d@er-murazor.conectium.com> (Adrian
 Almenar's message of "Fri, 18 Jun 2004 15:51:17 -0400")
Message-ID: <jeisdofs5p.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Almenar <aalmenar@conectium.com> writes:

> i was looking at /sys on my machine yesterday and i found something
> strange.
>
> cd
> /sys/block/hda/device/block/device/block/device/block/device/block/...
> and that continues being almost infinite and recursive, it is normal
> ???

Consult your favourite Unix textbook and look up "symbolic links".  Then
look again at /sys/block/hda/device.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
