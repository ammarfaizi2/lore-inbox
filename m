Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266215AbUAGPkY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 10:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUAGPkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 10:40:23 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39407 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266215AbUAGPkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 10:40:19 -0500
Date: Wed, 7 Jan 2004 16:40:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: jgarzik@pobox.com, scott.feldman@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.1-rc1-mm2: no help text for E100_NAPI
Message-ID: <20040107154012.GA11523@fs.tum.de>
References: <20040105002056.43f423b1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105002056.43f423b1.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 12:20:56AM -0800, Andrew Morton wrote:
>...
> All 253 patches
>...
> 2.6.0-rc1-netdrvr-exp1.patch
>...

This patch adds an E100_NAPI option that doesn't has a help text in the 
Kconfig file.

Could you add a help text?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

