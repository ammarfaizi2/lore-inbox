Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSELTk6>; Sun, 12 May 2002 15:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315407AbSELTk5>; Sun, 12 May 2002 15:40:57 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:16140 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315406AbSELTk5>; Sun, 12 May 2002 15:40:57 -0400
Date: Sun, 12 May 2002 21:40:49 +0200
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pdc202xx.c fails to compile in 2.5.15
Message-ID: <20020512194049.GA29906@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <3CDD4DE5.5030200@evision-ventures.com> <877km99nt1.fsf_-_@atlas.iskon.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Sun, May 12, 2002 at 09:19:22PM +0200
> pdc202xx.x fails to compile in 2.5.15. Error messages below.
> 
> 
> pdc202xx.c:1453: unknown field `exnablebits' specified in initializer

That's a simple typing error - replace exnable by enable.

Good luck,
Jurriaan
-- 
The man who thinks he is smarter than his wife is married to a very smart
woman.
Debian GNU/Linux 2.4.19p8 on Alpha 988 bogomips load:0.12 0.06 0.01
