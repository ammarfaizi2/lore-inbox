Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbTEILV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 07:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbTEILV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 07:21:28 -0400
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:14321 "EHLO
	uran.deimos.one.pl") by vger.kernel.org with ESMTP id S262445AbTEILV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 07:21:27 -0400
Date: Fri, 9 May 2003 13:33:58 +0200
From: Damian =?iso-8859-2?Q?Ko=B3kowski?= <deimos@deimos.one.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.69 - no setfont and loadkeys on tty > 1
Message-ID: <20030509113358.GA14798@deimos.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
X-Age: 23 (1980.09.27 - libra)
X-Girl: 1 will be enough!
X-GG: 88988
X-ICQ: 59367544
X-JID: deimos@jabber.gda.pl
X-Operating-System: Slackware GNU/Linux, kernel 2.4.21-rc1-ac4, up  3:08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'am wondering why setfont and loadkeys in setting only on first tty.
It works (setting font map on all six tty) in 2.{2,4}.x.

I'am using _radeonfb_ with rv250if, could it be the reason?

Take care.

P.S. Do I need to attaah the config file?

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
