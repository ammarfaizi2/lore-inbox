Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbTJGOF2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 10:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbTJGOF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 10:05:28 -0400
Received: from play.smurf.noris.de ([192.109.102.42]:18562 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S262387AbTJGOFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 10:05:12 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: compile error with 2.6.0-test6 on ppc32
Date: Tue, 07 Oct 2003 16:04:54 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2003.10.07.14.04.52.707400@smurf.noris.de>
References: <3F7EE203.4030601@g-house.de> <pan.2003.10.04.17.39.19.402587@smurf.noris.de> <3F8071E8.1050303@g-house.de>
NNTP-Posting-Host: linux.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: play.smurf.noris.de 1065535494 18550 192.109.102.39 (7 Oct 2003 14:04:54 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Tue, 7 Oct 2003 14:04:54 +0000 (UTC)
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christian wrote:
>> That's a regression in binutils. Debian/unstable fixed it in version
>> 2.14.90.0.6-3.
> 
> indeed! i just have to update *even more* often :-)
> 
Or less often.  :-/

> hm, the term "regression" is only known to me from mathematics, but i 
> don't know how this could be related to compiling issues....

It's a fairly standard term. Basically, it means that some feature
(interpreted broadly, e.g. "compiles this piece of code correctly")
worked in version X but fails to do so due to a bug (as opposed to a
feature change or removal) in version Y, where Y>X. Most often, the first
step of fixing the problem is increasing X or decreasing Y successively so
that X==Y-1.

> Thank you, 2.6.0-test6 is compiling now.
You're welcome.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Virtue is its own punishment.
		-- Denniston

Righteous people terrify me ... virtue is its own punishment.
		-- Aneurin Bevan

