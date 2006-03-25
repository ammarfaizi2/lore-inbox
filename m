Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWCYNVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWCYNVp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 08:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWCYNVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 08:21:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50627 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751387AbWCYNVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 08:21:45 -0500
Subject: Re: [PATCH 05/08] Kconfig: VIDEO_DECODER must select FW_LOADER
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, mkrufky@linuxtv.org
In-Reply-To: <20060325041118.GF16955@kroah.com>
References: <20060325041118.GF16955@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 25 Mar 2006 10:21:30 -0300
Message-Id: <1143292891.4961.71.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sex, 2006-03-24 às 20:11 -0800, Greg KH escreveu:
> From: Michael Krufky <mkrufky@linuxtv.org>
> 
> The cx25840 module requires external firmware in order to function,
> so it must select FW_LOADER, but saa7115 and saa7129 do not require it.
> 
> Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
> Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Acked-by: Mauro Carvalho Chehab <mchehab@infradead.org>

Cheers, 
Mauro.

