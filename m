Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbULTMzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbULTMzr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 07:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbULTMzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 07:55:47 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:8390 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261502AbULTMzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 07:55:46 -0500
Date: Mon, 20 Dec 2004 13:55:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       lista4@comhem.se, linux-kernel@vger.kernel.org, mr@ramendik.ru,
       riel@redhat.com
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Message-ID: <20041220125506.GJ4424@dualathlon.random>
References: <1329986.1103525472726.JavaMail.tomcat@pne-ps1-sn1> <20041219231250.457deb12.akpm@osdl.org> <41C682F1.20200@yahoo.com.au> <41C6876D.7070702@kolivas.org> <41C69440.1090504@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C69440.1090504@kolivas.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 07:58:40PM +1100, Con Kolivas wrote:
> This patch should have the desired effect.

Look great Con, thanks.
