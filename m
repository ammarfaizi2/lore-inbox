Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279803AbRKFQp6>; Tue, 6 Nov 2001 11:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279798AbRKFQps>; Tue, 6 Nov 2001 11:45:48 -0500
Received: from fandango.cs.unitn.it ([193.205.199.228]:36612 "EHLO
	fandango.cs.unitn.it") by vger.kernel.org with ESMTP
	id <S279797AbRKFQpg>; Tue, 6 Nov 2001 11:45:36 -0500
From: Massimo Dal Zotto <dz@cs.unitn.it>
Message-Id: <200111061645.RAA02115@fandango.cs.unitn.it>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
In-Reply-To: <20011105231759.02B541195E@a.mx.spoiled.org> from Juri Haberland
 at "Nov 6, 2001 00:17:59 am"
To: Juri Haberland <juri@koschikode.com>
Date: Tue, 6 Nov 2001 17:45:13 +0100 (MET)
CC: linux-kernel@vger.kernel.org, stephane@tuxfinder.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Actually, I just tried plain 2.4.14-pre8 and the i8k-module *didn't*
> work with my i8000, but with the patch from Stephane it *does* ;)
> 
> Happy happy, joy joy...
> 
> Juri
> 
> PS: BIOS verion A17 if that matters
> 
> -- 
> Juri Haberland  <juri@koschikode.com> 
> 

Hi,

I have released version 1.2 of the driver. It contains Stephane's patches
for the I8100, a new i8kmon and some documentation. You can download from:

    http://www.debian.org/~dz/i8k/

Could you please explain what doesn't work with your I8000? Does the
module load? Can you read /proc/i8k?

-- 
Massimo Dal Zotto

+----------------------------------------------------------------------+
|  Massimo Dal Zotto               email: massimo.dalzotto@libero.it   |
|  Via Marconi, 141                phone: ++39-461534251               |
|  38057 Pergine Valsugana (TN)      www: http://www.cs.unitn.it/~dz/  |
|  Italy                                  http://www.debian.org/~dz/   |
|  gpg:   2DB65596  3CED BDC6 4F23 BEDA F489 2445 147F 1AEA 2DB6 5596  |
+----------------------------------------------------------------------+
