Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265686AbTFNQWb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 12:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265688AbTFNQWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 12:22:30 -0400
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:56824 "EHLO
	uran.deimos.one.pl") by vger.kernel.org with ESMTP id S265686AbTFNQWa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 12:22:30 -0400
Date: Sat, 14 Jun 2003 18:12:19 +0200
From: Damian =?iso-8859-2?Q?Ko=B3kowski?= <deimos@deimos.one.pl>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: mirsev@cicese.mx, linux-kernel@vger.kernel.org
Subject: Re: via-rhine strange behavior 2.4.21-rc8
Message-ID: <20030614161219.GA865@deimos.one.pl>
References: <200306121227.07122@gjs> <20030613170426.GB573@deimos.one.pl> <3EEA12C0.E15DBAF2@cicese.mx> <200306141112.25252@gjs>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200306141112.25252@gjs>
User-Agent: Mutt/1.4.1i
X-Age: 23 (1980.09.27 - libra)
X-Girl: one will be enough!
X-IM: JID:dEiMoS_DK@jabber.org ICQ:59367544 GG:88988
X-Operating-System: Slackware GNU/Linux, kernel 2.4.21, up 1 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 14, 2003 at 11:12:19AM +0100, Grzegorz Jaskiewicz wrote:
> Yep, it was vanilla 2.4.21-rc8 (which become 2.4.21 at the moment).

So if you wont to use via-rhine don't use the CONFIG_X86_UP_IOAPIC, and maby
compile -rc8-ac1 with new ACPI.

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
