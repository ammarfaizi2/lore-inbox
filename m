Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267883AbTBVLtV>; Sat, 22 Feb 2003 06:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267885AbTBVLtV>; Sat, 22 Feb 2003 06:49:21 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:36625 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id <S267883AbTBVLtU>;
	Sat, 22 Feb 2003 06:49:20 -0500
Date: Sat, 22 Feb 2003 12:59:23 +0100
From: romieu@fr.zoreil.com
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ethernet-ATM-Router freezing
Message-ID: <20030222125923.A14935@electric-eye.fr.zoreil.com>
Reply-To: linux-kernel@vger.kernel.org
References: <20030222084958.GC23827@torres.ka0.zugschlus.de> <20030222113416.A14834@electric-eye.fr.zoreil.com> <20030222112553.GB24580@torres.ka0.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030222112553.GB24580@torres.ka0.zugschlus.de>; from mh+linux-kernel@zugschlus.de on Sat, Feb 22, 2003 at 12:25:53PM +0100
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Haber <mh+linux-kernel@zugschlus.de> :
[...]
> 00:0f.0 ATM network controller: FORE Systems Inc PCA-200E
>         Flags: bus master, medium devsel, latency 64, IRQ 9
>         Memory at efa00000 (32-bit, non-prefetchable) [size=2M]
>         Expansion ROM at effe0000 [disabled] [size=8K]

Ok, 2.4.20-ac1 made me fear an "guess who modified iphase driver" 
answer :o)

[...]
> I will downgrade one of the boxes to 2.4.20 later today. This is going
> to be a busy weekend anyway :-(

Finding the first non-working kernel may help but you really should
include some more setup describing data (lspci -vv, lsmod and others
as suggested in REPORTING-BUGS file).

Regards

--
Ueimor
