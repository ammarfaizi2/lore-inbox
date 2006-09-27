Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031151AbWI0WhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031151AbWI0WhK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031164AbWI0WhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:37:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6286 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1031151AbWI0WhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:37:07 -0400
Subject: Re: GPLv3 Position Statement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
       Nicolas Mailhot <nicolas.mailhot@laposte.net>,
       linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <Pine.LNX.4.64.0609271336200.3952@g5.osdl.org>
References: <43447.192.54.193.51.1159350218.squirrel@rousalka.dyndns.org>
	 <Pine.LNX.4.64.0609271031300.3952@g5.osdl.org>
	 <m33bad9hgy.fsf@defiant.localdomain>
	 <Pine.LNX.4.64.0609271336200.3952@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 28 Sep 2006 00:01:29 +0100
Message-Id: <1159398089.11049.381.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-27 am 13:41 -0700, ysgrifennodd Linus Torvalds:
> I think the hatred of pins became so high that it became almost 
> unacceptable for motherboard designers to add them on PC's. Nobody wants 
> to open their case any more ;)

Actually some of the smarter ones wired it to the SMM indications in the
chipset so that only BIOS controlled SMM management code can do the
update and that does checksumming or basic very crude crypto type
checks.

Fortunately the thought of a slammer equivalent that erases the firmware
isn't something most vendors want to risk their stock price and business
on.

Alan

