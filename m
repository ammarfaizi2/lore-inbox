Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263960AbSKDAHr>; Sun, 3 Nov 2002 19:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263966AbSKDAHr>; Sun, 3 Nov 2002 19:07:47 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:782 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263960AbSKDAHq>; Sun, 3 Nov 2002 19:07:46 -0500
From: Han-Wen Nienhuys <hanwen@cs.uu.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15813.48350.956277.727824@blauw.xs4all.nl>
Date: Mon, 4 Nov 2002 01:18:38 +0100
To: "David McIlwraith" <quack@bigpond.net.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Help!] 2.4.20 IDE-SCSI / CD-writing crash
In-Reply-To: <051b01c28391$47168530$41368490@archaic>
References: <3DC59E5B.2040007@yahoo.com>
	<200211032253.gA3Mrw1B008818@smtpzilla1.xs4all.nl>
	<1036365120.1540.11.camel@god.stev.org>
	<15813.44941.592105.853906@blauw.xs4all.nl>
	<051b01c28391$47168530$41368490@archaic>
X-Mailer: VM 7.05 under Emacs 21.2.1
Reply-To: hanwen@cs.uu.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

quack@bigpond.net.au writes:
> You mean hdc not hdd, I hope?

Plugged cdrom into hdc, switched off DMA on hdc. Managed to burn 3
times without crashing, on the 4th time, I get the "ATAPI reset" slow
agonizing death phenomenon again.


-- 
Han-Wen Nienhuys   |   hanwen@cs.uu.nl   |   http://www.cs.uu.nl/~hanwen 
