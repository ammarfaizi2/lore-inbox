Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318561AbSICOgv>; Tue, 3 Sep 2002 10:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318709AbSICOgv>; Tue, 3 Sep 2002 10:36:51 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:28938 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318561AbSICOgv>; Tue, 3 Sep 2002 10:36:51 -0400
Date: Tue, 3 Sep 2002 16:41:01 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID5 checksum algorithm selection
Message-ID: <20020903144101.GA20593@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20020903161846.J18187@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020903161846.J18187@fi.muni.cz>
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Tue, Sep 03, 2002 at 04:18:46PM +0200
> 
> 	Why does the kernel decide to use the pIII_sse function,
> even though the p5_mmx is faster?
> 
> 	The kernel is 2.4.20-pre5-ac1.
> 
Try the source, there's a comment at the end of include/i386/xor.h that
explains (not in great detail, but perhaps google or another archive can
help there?).

Good luck,
Jurriaan
-- 
Intel - they couldn't spell intelligent!
GNU/Linux 2.4.20-pre4-ac2 SMP/ReiserFS 2x1402 bogomips load av: 0.08 0.06 0.07
