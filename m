Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbTFBMpu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTFBMpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:45:50 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:1492 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S262278AbTFBMpt (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 2 Jun 2003 08:45:49 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16091.18977.642080.798274@laputa.namesys.com>
Date: Mon, 2 Jun 2003 16:59:13 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Gianni Tedesco <gianni@scaramanga.co.uk>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Linus Torvalds <Torvalds@Transmeta.COM>, Andrew Morton <AKPM@Digeo.COM>,
       Russell King <RMK@Arm.Linux.ORG.UK>
Subject: Re: const from include/asm-i386/byteorder.h
In-Reply-To: <20030602124016.GP8978@holomorphy.com>
References: <16088.47088.814881.791196@laputa.namesys.com>
	<1054406992.4837.0.camel@sherbert>
	<20030531185709.GK8978@holomorphy.com>
	<16091.14923.815819.792026@laputa.namesys.com>
	<20030602121457.GO8978@holomorphy.com>
	<16091.17602.257293.364468@laputa.namesys.com>
	<20030602124016.GP8978@holomorphy.com>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta11) "cabbage" XEmacs Lucid
X-NSA-Fodder: NORAD Khaddafi plutonium Marxist SCUD missile Albania Kennedy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:

[...]

 > 
 > Sounds good. If you could doublecheck the assembly to make sure it's
 > doing the right thing, that would be good, too.

I have neither ARM hardware nor knowledge of their assembly. Maybe
someone from ARM development team will help.

 > 
 > Thanks.
 > 
 > -- wli
