Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbUAFJ1i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 04:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUAFJ1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 04:27:38 -0500
Received: from host33-138.pool80181.interbusiness.it ([80.181.138.33]:11780
	"EHLO kratorius.ath.cx") by vger.kernel.org with ESMTP
	id S261613AbUAFJ1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 04:27:37 -0500
Date: Tue, 6 Jan 2004 10:26:56 +0100
From: Giuliani Ivan <kratorius@lugbari.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1 affected?
Message-Id: <20040106102656.7cd1e55b@malattia.net>
In-Reply-To: <20040106063906.GB27889@unthought.net>
References: <1073320318.21198.2.camel@midux>
	<Pine.LNX.4.58.0401050840290.21265@home.osdl.org>
	<1073326471.21338.21.camel@midux>
	<Pine.LNX.4.58.0401051027430.2115@home.osdl.org>
	<20040105193817.GA4366@lsc.hu>
	<20040105224855.GC4987@louise.pinerecords.com>
	<1073348624.1790.43.camel@louise3.void.org>
	<20040106063906.GB27889@unthought.net>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jan 2004 07:39:06 +0100
Jakob Oestergaard <jakob@unthought.net> wrote:

> On Tue, Jan 06, 2004 at 01:23:44AM +0100, Bastiaan Spandaw wrote:
> ...
> > Not sure if this works or not.
> > According to a slashdot comment this is proof of concept code.
> > 
> > http://linuxfromscratch.org/~devine/mremap_poc.c
> 
> A few tests, all on IA32, all as non-root user:
> 
> RedHat 5.2, (vanilla 2.0.39) = no effect
> RedHat 6.2, (vanilla 2.4.18) = instant reboot
> RedHat 7.2, (redhat 2.4.9-7) = instant reboot
> Debian 2.2, (vanilla 2.2.19) = no effect
> SuSE 7.3, (suse 2.4.10-4GB) = instant reboot

On my 2.4.22 (slackware 9.1 default) and on my 2.6.0-test11 (vanilla) with IA32
worked fine.

-- 
Ivan "kratorius" Giuliani  ::  PGP Public Key ID:
http://kratorius.cjb.net   ::  0x840F429D @ keyserver.linux.it
LUGBari Member             ::
