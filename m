Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTJKLDT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 07:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTJKLDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 07:03:19 -0400
Received: from play.smurf.noris.de ([192.109.102.42]:25288 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S263275AbTJKLDS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 07:03:18 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: Do I have to buy a license to use BK for kernel development?
Date: Sat, 11 Oct 2003 13:02:23 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2003.10.11.11.02.19.438640@smurf.noris.de>
References: <1063167031.3399.7.camel@laptop-linux> <20030910045941.GD1990@work.bitmover.com> <1063171071.4479.13.camel@laptop-linux>
NNTP-Posting-Host: linux.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: play.smurf.noris.de 1065870143 27358 192.109.102.39 (11 Oct 2003 11:02:23 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sat, 11 Oct 2003 11:02:23 +0000 (UTC)
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nigel Cunningham wrote:

> I did read the license and am happy to comply with it. I was wondering
> if there's something that is failing to work properly. Are there details
> somewhere on how BK expects to be able to send the data, or how it can
> be made to try to send it?

Basically, BK wants to send logging data. If it can't do that, after a
number of changes it stops working.

bk help log

So, as soon as you're online, just run "bk log" in every BK tree you've
worked at when offline.

You can use the -d option if you need to figure out what's happening.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Q:	What's a WASP's idea of open-mindedness?
A:	Dating a Canadian.

