Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265534AbTFMVSZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 17:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265535AbTFMVSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 17:18:25 -0400
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:5651 "EHLO
	deimos.one.pl") by vger.kernel.org with ESMTP id S265534AbTFMVSY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 17:18:24 -0400
Date: Fri, 13 Jun 2003 23:31:47 +0200 (CEST)
From: =?ISO-8859-2?Q?Damian_Ko=B3kowski?= <deimos@deimos.one.pl>
To: Daniel Egger <degger@fhm.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephan von Krawczynski <skraw@ithnet.com>, <stefan@stefan-foerster.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.21 released
In-Reply-To: <1055538278.11366.13.camel@sonja>
Message-ID: <Pine.LNX.4.44.0306132325110.26388-100000@wenus.deimos.one.pl>
X-OS: Slackware GNU/Linux
X-Age: 22 (1980.09.27 - libra)
X-Girl: 1 will be enough!
X-GG: 88988
X-ICQ: 59367544
X-GPG: http://deimos.one.pl/deimos.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jun 2003, Daniel Egger wrote:

> Surprise, but ACPI never was the problem with this board... :)

ROTFL

It is. As you know now.

> I've tested a few more kernels. .21 fails as well as the latest -ac.

Now you surprise me, so 2.4.21-rc8-ac1 with ACPI:

	CONFIG_X86_UP_APIC
	CONFIG_X86_UP_IOAPIC

with module via-rhine on ECS_L7VTA works for you or not..?

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #

