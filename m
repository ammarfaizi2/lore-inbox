Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265698AbUBBQ5Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 11:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUBBQ5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 11:57:24 -0500
Received: from users.linvision.com ([62.58.92.114]:3818 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S265698AbUBBQ5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 11:57:23 -0500
Date: Mon, 2 Feb 2004 17:57:21 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: george young <gry@ll.mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/config.z disappeared in 2.4.24
Message-ID: <20040202165721.GE1078@bitwizard.nl>
References: <20040202115224.64063795.gry@ll.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202115224.64063795.gry@ll.mit.edu>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 11:52:24AM -0500, george young wrote:
> [SuSE x86 linux 8.2, 2.4.24 kernel building]

[...]

> The /proc/config.z file seems to have disappeared! Is there some
> config parameter that enables this? Or has it gone away between 2.4.20
> and 2.4.24?

It didn't disappear, it has never been there. Both RedHat and SuSE have
a patch that include the kernel .config in the image itself, but that
feature is not in the official 2.4 kernel (it is however in 2.6).


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
