Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266184AbUAGLFR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 06:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUAGLFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 06:05:16 -0500
Received: from play.smurf.noris.de ([192.109.102.42]:60862 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S266184AbUAGLFL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 06:05:11 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: gaim problems in 2.6.0
Date: Wed, 07 Jan 2004 11:38:25 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.01.07.10.38.22.960565@smurf.noris.de>
References: <20040104172535.GA322@elf.ucw.cz> <3FF86F95.6040304@metalhen.de>
NNTP-Posting-Host: linux.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: play.smurf.noris.de 1073471905 25192 192.109.102.39 (7 Jan 2004 10:38:25 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Wed, 7 Jan 2004 10:38:25 +0000 (UTC)
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Benjamin Henne wrote:

> I also have problems with gnome and freezing when using 2.6.0.

Do you have CONFIG_PREEMPT turned on? I've noticed that it seems to
kill the stability of my PPC box when running X. Maybe there's a common
bug lurking somewhere.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
The descent to Hades is the same from every place.
		-- Anaxagoras

