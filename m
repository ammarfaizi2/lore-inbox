Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316882AbSIAMyd>; Sun, 1 Sep 2002 08:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316887AbSIAMyd>; Sun, 1 Sep 2002 08:54:33 -0400
Received: from p50887EBD.dip.t-dialin.net ([80.136.126.189]:4574 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316882AbSIAMyc>; Sun, 1 Sep 2002 08:54:32 -0400
Date: Sun, 1 Sep 2002 06:59:03 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Miles Lane <miles.lane@attbi.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.33 -- drivers/built-in.o: In function `isd200_get_inquiry_data':
 undefined reference to `ata_fix_driveid'
In-Reply-To: <1030877078.10475.2.camel@agate.localdomain>
Message-ID: <Pine.LNX.4.44.0209010658370.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1 Sep 2002, Miles Lane wrote:
> drivers/built-in.o: In function `isd200_get_inquiry_data':
> drivers/built-in.o(.text+0xc0652): undefined reference to
> `ata_fix_driveid'

That crap got removed in 2.5.31->2.5.32

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

