Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131426AbRCKO0e>; Sun, 11 Mar 2001 09:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131429AbRCKO0Y>; Sun, 11 Mar 2001 09:26:24 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16908 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131426AbRCKO0V>; Sun, 11 Mar 2001 09:26:21 -0500
Subject: Re: 2.4.3pre1: kernel BUG at page_alloc.c:73!
To: david@fortyoz.org
Date: Sun, 11 Mar 2001 14:28:22 +0000 (GMT)
Cc: kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org
In-Reply-To: <20010310231250.A5391@fortyoz.org> from "David Raufeisen" at Mar 10, 2001 11:12:50 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14c6pc-00006B-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, the kernel module is open source..

No the Nvidia kernel module is not. Try reading it, its obfuscated to point
of being binary, it contains no permission to modify or redistribute either.

In fact if you are using patched versions of it to make it work with later
kernels you may well be breaking their licensing
