Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbTJET76 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbTJET6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:58:33 -0400
Received: from play.smurf.noris.de ([192.109.102.42]:46254 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S263847AbTJET6T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:58:19 -0400
From: Matthias Urlichs <smurf@smurf.noris.de>
Organization: {M:U} IT Consulting
Subject: Re: compile error with 2.6.0-test6 on ppc32
Date: Sat, 04 Oct 2003 19:39:19 +0200
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Message-Id: <pan.2003.10.04.17.39.19.402587@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
References: <3F7EE203.4030601@g-house.de>
X-Pan-Internal-Attribution: Hi, Christian Kujau wrote:
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
X-Pan-Internal-Post-Server: smurf
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: recipient list not shown:;
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christian Kujau wrote:

> upon compiling kernel 2.6.0-test6 on my PowerPC 604r machine (PReP),
> i got the following error:
> 
That's a regression in binutils. Debian/unstable fixed it in version
2.14.90.0.6-3.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
...a noble practice which does honor to women.
		-- Sheik Gad Al Haq Ali Gad Al Haq, explaining
		   clitorectomy
