Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264380AbTEPI0z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 04:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264381AbTEPI0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 04:26:55 -0400
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:5623 "EHLO
	uran.deimos.one.pl") by vger.kernel.org with ESMTP id S264380AbTEPI0y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 04:26:54 -0400
Date: Fri, 16 May 2003 10:39:39 +0200
From: Damian =?iso-8859-2?Q?Ko=B3kowski?= <deimos@deimos.one.pl>
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: radeonfb and high mem
Message-ID: <20030516083939.GB1687@deimos.one.pl>
References: <20030515194118.GA696@gandalf.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030515194118.GA696@gandalf.home.lxtec.de>
User-Agent: Mutt/1.4.1i
X-Age: 23 (1980.09.27 - libra)
X-Girl: 1 will be enough!
X-GG: 88988
X-ICQ: 59367544
X-JID: deimos@jabber.gda.pl
X-Operating-System: Slackware GNU/Linux, kernel 2.4.21-rc2-ac1, up  1:05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 09:41:18PM +0200, Elimar Riesebieter wrote:
> I am running 2.4.21.rc2-ac2 with 1 GB RAM. The radeonfb can't map
> FB. If I boot with mem=840MB the framebuffer runs. I thought it will
> be fixed with the vesa_highmem fix but isn't with vesafb at all. The
> same happens with noacpi ;-) The RAM is tested as good with memtest!

Use that:
	http://gate.crashing.org/~ajoshi/radeonfb-0.1.8.diff.gz

P.S. It's for 2.4.21-rc1

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
