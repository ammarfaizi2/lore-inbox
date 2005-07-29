Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVG2Qip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVG2Qip (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 12:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVG2QgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 12:36:00 -0400
Received: from pike.sandelman.ca ([205.150.200.164]:10739 "EHLO
	pike.sandelman.ca") by vger.kernel.org with ESMTP id S262655AbVG2Qdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 12:33:41 -0400
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, kyle@mcmartin.ca,
       "Gala Kumar K.-galak" <galak@freescale.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 00/14] ppc32: Remove board ports that are no longer maintained 
In-Reply-To: Message from Kumar Gala <kumar.gala@freescale.com> 
   of "Wed, 27 Jul 2005 18:34:23 CDT." <3965D4DD-1628-4463-890F-106DB5BC6931@freescale.com> 
References: <20050727101502.B1114@cox.net>  <3965D4DD-1628-4463-890F-106DB5BC6931@freescale.com> 
X-Mailer: MH-E 7.82; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 29 Jul 2005 12:33:33 -0400
Message-ID: <5027.1122654813@marajade.sandelman.ottawa.on.ca>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Kumar" == Kumar Gala <kumar.gala@freescale.com> writes:
    >> When we recover our history from the linuxppc-2.4/2.5 trees we
    >> can show exactly how long it's been since anybody touched ep405.
    >> 
    >> Quick googling shows that it's been almost 2 years since the last
    >> mention of ep405 (exluding removal discussions) on
    >> linuxppc-embedded.  Last ep405-related commits are more than 2
    >> years ago.

  So, I'll bet I can find other parts of the kernel tree that haven't
been touched in 2 years.  Maybe there isn't anything to fix?

  Happens that in our case,
	  a) the board is the basis to our own board.
	  b) we only moved to 2.6 in May.

  So, I just don't get removing board support files.

- -- 
] Michael Richardson          Xelerance Corporation, Ottawa, ON |  firewalls  [
] mcr @ xelerance.com           Now doing IPsec training, see   |net architect[
] http://www.sandelman.ca/mcr/    www.xelerance.com/training/   |device driver[
]                    I'm a dad: http://www.sandelman.ca/lrmr/                 [
  
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQupaXIqHRg3pndX9AQFnGQP+JXX0ZTKW35LljC/ighUPpmcdClRlmWP2
fsnofXYNi2v9QEkYpoS8pHMc3ClKHT8MFzK/nsDe1CFWPxxavK+365usf77DSGWB
bjZ8CZWjkvDt7IMjBxEnSlzCTVt39Gtjq1zM/DMY0SOi1ccB7TIZE+1Ol3zkYnW5
2X6+0SKgS6Q=
=kcQj
-----END PGP SIGNATURE-----
