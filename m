Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966260AbWKNUCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966260AbWKNUCp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966298AbWKNUCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:02:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33287 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S966260AbWKNUCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:02:44 -0500
Date: Tue, 14 Nov 2006 21:02:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
       Don Mullis <dwm@meer.net>
Subject: 2.6.19-rc5-mm2: no help text for FAULT_INJECTION
Message-ID: <20061114200249.GM22565@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
> +fault-injection-Kconfig-cleanup.patch
>...
>  Fault-injection framework and applications thereof.
>...

The FAULT_INJECTION option lacks a help text.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

