Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316141AbSEVPbg>; Wed, 22 May 2002 11:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316155AbSEVPbf>; Wed, 22 May 2002 11:31:35 -0400
Received: from www.wireboard.com ([216.151.155.101]:40362 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id <S316141AbSEVPbe>; Wed, 22 May 2002 11:31:34 -0400
To: "Rose, Billy" <wrose@loislaw.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: RedHat 7.2 Stock SMP Install
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD0962E2BE@loisexc2.loislaw.com>
From: Doug McNaught <doug@wireboard.com>
Date: 22 May 2002 11:31:31 -0400
Message-ID: <m3ptzo6vxo.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rose, Billy" <wrose@loislaw.com> writes:

> I have an HP LPr Dual P-III 550 with 2 18G SCSI drives that locked
 up.

> Linux warnock 2.4.7-10smp #1 SMP Thu Sep 6 17:09:31 EDT 2001 i686 unknown
                ^^^^^^^^^^^
Try the latest errata kernel for 7.2 and see if it still happens.
There's a reason they release kernel update packages...

-Doug
