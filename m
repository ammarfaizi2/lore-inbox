Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbUCPTBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUCPTBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:01:41 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:48089 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261202AbUCPTBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:01:39 -0500
Date: Tue, 16 Mar 2004 20:01:38 +0100 (MET)
From: News Admin <news@nimloth.ics.muni.cz>
Message-Id: <200403161901.i2GJ1cvi003307@nimloth.ics.muni.cz>
To: linux-kernel@vger.kernel.org
X-Muni-Spam-TestIP: 147.251.6.10
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From news Tue Mar 16 20:01:33 2004
Received: (from news@localhost)
	by nimloth.ics.muni.cz (8.12.8/8.10.0.Beta12) id i2GJ1Wxp003288
	for newsmaster; Tue, 16 Mar 2004 20:01:32 +0100 (MET)
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Petr Konecny <pekon@fi.muni.cz>
Subject: Re: 2.6.5-rc1-mm1 hangs after Uncompressing kernel...
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Message-ID: <qwwr7vsr4z8.fsf@decibel.fi.muni.cz>
Sender: UNKNOWN@decibel.fi.muni.cz
Cancel-Lock: sha1:UrNeVavozK+U9miLpeuonswh0Dc=
Cc: manfred@colorfullife.com, akpm@osdl.org
Date: Tue, 16 Mar 2004 19:01:31 GMT
X-Nntp-Posting-Host: decibel.fi.muni.cz
X-Url: http://www.fi.muni.cz/~pekon/
Content-Type: text/plain; charset=us-ascii
References: <20040316175156.GA11785@nikolas.hn.org>
Mime-Version: 1.0
Organization: unknown

>>>>> Nick Orlov (Nick) said:

 Nick> 2.6.5-rc1-mm1 with 4k-stacks-always-on reverted hangs after
 Nick> "Uncompressing kernel ..."

 Nick> reverting early-x86-cpu-detection-fix solved the problem for me.
Same here. 4kstacks enabled, reverting early-x86-cpu-detection-fix fixes
the hang.  Mobile Intel(R) Pentium(R) 4 CPU 2.30GHz in HP pavilion
ze5500.

                                        Petr

