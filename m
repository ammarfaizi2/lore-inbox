Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272335AbTHILnK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 07:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272336AbTHILnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 07:43:10 -0400
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:12557 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S272335AbTHILnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 07:43:09 -0400
To: Daniel Blueman <daniel.blueman@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.0-t1 sis900 timeout
Mail-Copies-To: nobody
References: <8723.1059984634@www20.gmx.net>
From: kilobug@freesurf.fr (=?iso-8859-1?q?Ga=EBl_Le_Mignot?=)
Organization: HurdFr - http://hurdfr.org
X-PGP-Fingerprint: 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA
Date: Sat, 09 Aug 2003 13:47:45 +0200
In-Reply-To: <8723.1059984634@www20.gmx.net> (Daniel Blueman's message of
 "Mon, 4 Aug 2003 10:10:34 +0200 (MEST)")
Message-ID: <plopm3he4r3vdq.fsf@drizzt.kilobug.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > Can you check if the IRQ allocated to the SiS900 is the same on kernels
 > where it does work, and try without ACPI support, and/or any IO-APIC support
 > disabled?

This IRQ is the same (10) with 2.4.20 (which works fine). 

-- 
Gael Le Mignot "Kilobug" - kilobug@nerim.net - http://kilobug.free.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

Member of HurdFr: http://hurdfr.org - The GNU Hurd: http://hurd.gnu.org
