Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265688AbTFNQ0p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 12:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbTFNQ0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 12:26:45 -0400
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:58360 "EHLO
	uran.deimos.one.pl") by vger.kernel.org with ESMTP id S265688AbTFNQ0p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 12:26:45 -0400
Date: Sat, 14 Jun 2003 18:16:24 +0200
From: Damian =?iso-8859-2?Q?Ko=B3kowski?= <deimos@deimos.one.pl>
To: Krzysiek Taraszka <dzimi@pld.org.pl>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, stefan@stefan-foerster.de,
       linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.21 released
Message-ID: <20030614161624.GB865@deimos.one.pl>
References: <200306131453.h5DErX47015940@hera.kernel.org> <20030613165628.GE28609@in-ws-001.cid-net.de> <20030613165625.GA573@deimos.one.pl> <20030613193709.49f22332.skraw@ithnet.com> <20030613171903.GA797@deimos.one.pl> <Pine.LNX.4.50L.0306141753020.20957-100000@ep09.kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.50L.0306141753020.20957-100000@ep09.kernel.pl>
User-Agent: Mutt/1.4.1i
X-Age: 23 (1980.09.27 - libra)
X-Girl: one will be enough!
X-IM: JID:dEiMoS_DK@jabber.org ICQ:59367544 GG:88988
X-Operating-System: Slackware GNU/Linux, kernel 2.4.21, up 1 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 14, 2003 at 05:59:38PM +0200, Krzysiek Taraszka wrote:
> I have got the same problem few days ago. Quick fix was: append="noapic 
> acpi=off"
> I did not check new apci stuff, maybe acpi maintainers fixed that bug ? If 
> they are changes should go as soon as possible into Marcelo bk tree :)

I discover that the simple way will be not to use the CONFIG_X86_UP_IOAPIC.
But I don't know if it is the good solution.

For me, the simple way is too use the GOOD WORKING APM :-)

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
