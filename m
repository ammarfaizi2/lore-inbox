Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271411AbTHMGaH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 02:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271412AbTHMGaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 02:30:07 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:40456 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S271411AbTHMGaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 02:30:03 -0400
Date: Wed, 13 Aug 2003 08:30:01 +0200
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SOLUTION Re: 2.6.0-test3 cannot mount root fs
Message-ID: <20030813063001.GE24994@gamma.logic.tuwien.ac.at>
References: <20030813061546.GB24994@gamma.logic.tuwien.ac.at> <E19mp6A-000Osj-00.arvidjaar-mail-ru@f16.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E19mp6A-000Osj-00.arvidjaar-mail-ru@f16.mail.ru>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mit, 13 Aug 2003, "Andrey Borzenkov"  wrote:
> congratulations :)

:-)))

> well, I always do make distclean after patch ... I cannot afford
> loading 30MB every week.

I *ALWAYS* do 
	make distclean
and
	make mrproper
and all other incantations of cleaning, too! This was NOT the problem,
but a wrongly diff file obviously messed up the kernel.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
Zaphod grinned two manic grins, sauntered over to the bar
and bought most of it.
                 --- Zaphod in paradise.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
