Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264864AbUFQQ2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264864AbUFQQ2w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 12:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266563AbUFQQ2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 12:28:51 -0400
Received: from catv-5062fad2.catv.broadband.hu ([80.98.250.210]:39179 "EHLO
	balabit.hu") by vger.kernel.org with ESMTP id S264864AbUFQQ2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 12:28:50 -0400
Subject: Re: kernel oops on ia64 (2.6.6 + 0521 ia64 patch)
From: Balazs Scheidler <bazsi@balabit.hu>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16592.60876.886257.165633@napali.hpl.hp.com>
References: <1087420973.4345.19.camel@bzorp.balabit>
	 <16592.60876.886257.165633@napali.hpl.hp.com>
Content-Type: text/plain; charset=iso-8859-2
Message-Id: <1087489727.30553.0.camel@bzorp.balabit>
Mime-Version: 1.0
Date: Thu, 17 Jun 2004 18:28:48 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2004-06-17, cs keltezéssel 03:03-kor David Mosberger ezt írta:
>   Balazs> I'm encountering more-or-less reproducible oopses on a 2.6.6
>   Balazs> kernel with 0521 ia64 patch, compiled with gcc 3.3.3 on
>   Balazs> Debian sarge.
> 
>   Balazs> The box is a HP rx2600 with a single processor, kernel is
>   Balazs> compiled in UP mode. Here is the backtrace (saved off froma
>   Balazs> terminal session on the network console, thus the
>   Balazs> formatting, but the info should be correct).
> 
> Does the oops go away with an SMP kernel?
> 

yes, it does.

-- 
Bazsi
PGP info: KeyID 9AF8D0A9 Fingerprint CD27 CFB0 802C 0944 9CFD 804E C82C 8EB1


