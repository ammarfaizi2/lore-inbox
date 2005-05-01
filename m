Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVEAX56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVEAX56 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 19:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVEAX56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 19:57:58 -0400
Received: from cantor2.suse.de ([195.135.220.15]:64188 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261399AbVEAX54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 19:57:56 -0400
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove BK documentation
References: <20050501233441.GC3592@stusta.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: They don't hire PERSONAL PINHEADS, Mr. Toad!
Date: Mon, 02 May 2005 01:57:53 +0200
In-Reply-To: <20050501233441.GC3592@stusta.de> (Adrian Bunk's message of
 "Mon, 2 May 2005 01:34:41 +0200")
Message-ID: <jer7gqqz26.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> --- linux-2.6.12-rc2-mm2-full/fs/cifs/README.old	2005-04-09 19:08:06.000000000 +0200
> +++ linux-2.6.12-rc2-mm2-full/fs/cifs/README	2005-04-09 19:08:29.000000000 +0200
> @@ -32,9 +32,9 @@
>  6) make modules (or "make" if CIFS VFS not to be built as a module)
>  
>  For Linux 2.6:
> -1) Download the kernel (e.g. from http://www.kernel.org or from bitkeeper
> -at bk://linux.bkbits.net/linux-2.5) and change directory into the top
> -of the kernel directory tree (e.g. /usr/src/linux-2.5.73)
> +1) Download the kernel (e.g. from http://www.kernel.org
> +and change directory into the top of the kernel directory tree
> +(e.g. /usr/src/linux-2.5.73)

That lacks a closing paren now.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
