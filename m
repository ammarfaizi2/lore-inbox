Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTIGSoN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 14:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTIGSoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 14:44:13 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:49661 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S261151AbTIGSoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 14:44:11 -0400
Date: Sun, 7 Sep 2003 14:41:11 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Henning Schmiedehausen <hps@intermeta.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
In-Reply-To: <1062935718.5167.0.camel@uzi.hutweide.de>
Message-ID: <Pine.GSO.4.33.0309071435200.13584-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Sep 2003, Henning Schmiedehausen wrote:
>> 64B is the minimum ETHERNET frame size.  That isn't true for PPP, HDLC,
>> Frame relay, ATM, etc.
>
>We were talking 100 MBit Ethernet, weren't we? ;-)

Actually, we're talking about VoIP between remote offices.  We already
know this is not accomplished via fast ethernet WAN links.  The WAN
link is, in fact, a T1.  T1's do not have minimum frame sizes like
ethernet.

--Ricky


