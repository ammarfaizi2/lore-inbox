Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbTLZSW7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 13:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbTLZSWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 13:22:45 -0500
Received: from play.smurf.noris.de ([192.109.102.42]:63435 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S265200AbTLZSWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 13:22:43 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: SUCCESS Re: 2.6.0-test11-mm1
Date: Fri, 26 Dec 2003 19:22:19 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2003.12.26.18.22.17.611727@smurf.noris.de>
References: <20031217014350.028460b2.akpm@osdl.org>
NNTP-Posting-Host: linux.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: play.smurf.noris.de 1072462939 5092 192.109.102.39 (26 Dec 2003 18:22:19 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Fri, 26 Dec 2003 18:22:19 +0000 (UTC)
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew Morton wrote:
> [ 2.6.0-mm1 ]

"User" report: I've had lost of stability problems with 2.6-test*,
including 2.6.0-no_test, on my laptop. Stuff like misplaced characters
in Galeon, crashing Konsole, inexplicable delays in pan, et al., which
never happened with 2.4.

For what it's worth, these seem to be gone for good since I rebooted into
-mm1 this morning. So, thanks to whoever's responsible for the patch that
actually fixed the problem.


If somebody _really_ needs to know, I can try to binary-search for the
patch that's responsible, but it'd take a month to find out anything
conclusive -- ten reboots, two days of stress testing each in order to
eliminate false positives, and a few days of no-computer-please,
I-need-a-holiday time. Thus, I'd rather not.


I've stored a Bitkeeper archive of the -mm1 patches (one changeset per
patch) to bk://smurf.bkbits.net/linux-2.6-mm, for those (like me ;-)
who don't like to work with patches. I'll keep that up-to-date so that
there's a clean upgrade path.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Murray's Rule:
	Any country with "democratic" in the title isn't.

