Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbTJET77 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTJET63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:58:29 -0400
Received: from play.smurf.noris.de ([192.109.102.42]:45742 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S263846AbTJET6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:58:16 -0400
From: Matthias Urlichs <smurf@smurf.noris.de>
Organization: {M:U} IT Consulting
Subject: Re: 2.6.0-test5 & test6 cd burning/scheduler/ide-scsi.c bug
Date: Sat, 04 Oct 2003 17:19:41 +0200
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Message-Id: <pan.2003.10.04.15.19.41.905451@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
References: <3F7CCEB8.8040803@spe.midco.net> <Pine.LNX.4.53.0310022146120.2108@montezuma.fsmlabs.com>
X-Pan-Internal-Attribution: Hi, Zwane Mwaikambo wrote:
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
X-Pan-Internal-Post-Server: smurf
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: recipient list not shown:;
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Zwane Mwaikambo wrote:

>>  This is my first bug submission, so please have patience with my noobness :)
> 
> The general consensus is that you should be using the direct ATAPI 
> interface for cd-writing in 2.6.

That doesn't change the fact that programs which worked perfectly well
under 2.4.xx now hang, instead of either working perfectly ;-) or getting
hit with an error, or at least a deprecation warning.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"To your left is the marina where several senior cabinet officials keep luxury
yachts for weekend cruises on the Potomac.  Some of these ships are up to 100
feet in length; the Presidential yacht is over 200 feet in length, and can
remain submerged for up to 3 weeks."
-- Garrison Keillor
