Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbTILRLq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 13:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbTILRLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 13:11:46 -0400
Received: from dsl092-073-159.bos1.dsl.speakeasy.net ([66.92.73.159]:36365
	"EHLO yupa.krose.org") by vger.kernel.org with ESMTP
	id S261777AbTILRLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 13:11:45 -0400
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: ken@krwtech.com, linux-kernel@vger.kernel.org
Subject: Re: NVIDIA proprietary driver problem
References: <87u17if7eu.fsf@nausicaa.krose.org>
	<Pine.LNX.4.51.0309121553500.14124@dns.toxicfilms.tv>
	<87r82mf6j9.fsf@nausicaa.krose.org>
	<Pine.LNX.4.56.0309121023440.973@death>
	<20030912162812.GA10942@vana.vc.cvut.cz>
X-Home-Page: http://www.krose.org/~krose/
From: Kyle Rose <krose+linux-kernel@krose.org>
Organization: krose.org
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 12 Sep 2003 13:11:35 -0400
In-Reply-To: <20030912162812.GA10942@vana.vc.cvut.cz> (Petr Vandrovec's
 message of "Fri, 12 Sep 2003 18:28:12 +0200")
Message-ID: <87llsuextk.fsf@nausicaa.krose.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Rational FORTRAN,
 i386-debian-linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BIOS has setting whether IRQ should be assigned to the VGA card
> or not - default is not, and if you'll leave it this way, you'll get
> no IRQ:

As far as I can tell, my BIOS has no such option.  I went through it
with a fine-toothed comb last night.  But, given the report from Ken,
I'll do a build from scratch of everything (including the ReiserFS
patch.  Thanks Oleg!)

Cheers,
Kyle
