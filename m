Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265618AbTFNFVx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 01:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265619AbTFNFVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 01:21:53 -0400
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:39924 "EHLO
	uran.deimos.one.pl") by vger.kernel.org with ESMTP id S265618AbTFNFVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 01:21:53 -0400
Date: Sat, 14 Jun 2003 07:11:37 +0200
From: Damian =?iso-8859-2?Q?Ko=B3kowski?= <deimos@deimos.one.pl>
To: Serguei Miridonov <mirsev@cicese.mx>
Cc: Grzegorz Jaskiewicz <gj@pointblue.com.pl>, linux-kernel@vger.kernel.org
Subject: Re: via-rhine strange behavior 2.4.21-rc8
Message-ID: <20030614051137.GA968@deimos.one.pl>
References: <200306121227.07122@gjs> <20030613170426.GB573@deimos.one.pl> <3EEA12C0.E15DBAF2@cicese.mx> <20030613175959.GA1495@deimos.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030613175959.GA1495@deimos.one.pl>
User-Agent: Mutt/1.4.1i
X-Age: 23 (1980.09.27 - libra)
X-Girl: one will be enough!
X-IM: JID:dEiMoS_DK@jabber.org ICQ:59367544 GG:88988
X-Operating-System: Slackware GNU/Linux, kernel 2.4.21, up 1 min,  1 user,  load average: 0.09, 0.05, 0.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 07:59:59PM +0200, Damian Ko³kowski wrote:
> I was using tha -pre, -rc, -ac with ACPI and via-rhine on my ECS was not
> working.
> 
> P.S. Right now I'am compiling -rc8-ac1 with new ACPI, I will check in
> once again on my slack-current.

It works, but without the CONFIG_X86_UP_IOAPIC.

P.S. It's normal PC desktop, not laptop :-)

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
