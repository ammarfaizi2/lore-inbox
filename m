Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265450AbTFMROt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 13:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265451AbTFMROt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 13:14:49 -0400
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:37875 "EHLO
	uran.deimos.one.pl") by vger.kernel.org with ESMTP id S265450AbTFMROm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 13:14:42 -0400
Date: Fri, 13 Jun 2003 19:04:26 +0200
From: Damian Kolkowski <deimos@deimos.one.pl>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: linux-kernel@vger.kernel.org, rl@hellgate.ch
Subject: Re: via-rhine strange behavior 2.4.21-rc8
Message-ID: <20030613170426.GB573@deimos.one.pl>
References: <200306121227.07122@gjs>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200306121227.07122@gjs>
User-Agent: Mutt/1.4.1i
X-Age: 23 (1980.09.27 - libra)
X-Girl: 1 will be enough!
X-GG: 88988
X-ICQ: 59367544
X-JID: dEiMoS_DK@jabber.org
X-Operating-System: Slackware GNU/Linux, kernel 2.4.21-rc8, up 0 min,  1 user,  load average: 0.22, 0.06, 0.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 12:27:02PM +0100, Grzegorz Jaskiewicz wrote:
> I attached dmesg from one of my test toys (servers). I am not able to get 
> via-rhine card to work on it :/

Hi I have via-rhine to on my ECS_L7VTA and whenever I use ACPId thet network
card is not working.

So.., remove ACPI form kernel :-)

> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!

Maby if we have some not integrated network card based on via-rhine we could
heck it why ACPI locks via-rhine; but there in probably no via-rhine outside
the main bord :-)

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
