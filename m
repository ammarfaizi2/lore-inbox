Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263563AbUDMLpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 07:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbUDMLpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 07:45:22 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54765 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263563AbUDMLpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 07:45:18 -0400
Date: Tue, 13 Apr 2004 13:36:59 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>,
       Raghavendra Koushik <raghavendra.koushik@s2io.com>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.5-mm5: no help text for S2IO_NAPI
Message-ID: <20040413113659.GN27003@fs.tum.de>
References: <20040412221717.782a4b97.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040412221717.782a4b97.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 10:17:17PM -0700, Andrew Morton wrote:
>...
> All 215 patches:
>...
> bk-netdev.patch
>...

There is no help text for S2IO_NAPI in the Kconfig file, please add one.

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

