Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbUAZUoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 15:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbUAZUoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 15:44:17 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:53642 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S265111AbUAZUoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 15:44:15 -0500
Date: Mon, 26 Jan 2004 21:44:12 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Boot problem with 2.6.2-rc2
Message-ID: <20040126204412.GX9603@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040126144947.GD6769@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040126144947.GD6769@charite.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:
> Hi!
> On my Toshiba Sattelite Pro 6100 I cannot boot 2.6.2-rc2. Right now
> I'm using 2.6.1-mm4, which works like a charm.
> 
> Booting 2.6.2-rc2 just gives me a black screen with absoulutely no
> output and no activity.

neither
initcall_debug 
nor
nmi_watchdog=1
or
nmi_watchdog=2 doesn't alter anything when used as append options when
booting.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
Referat V a - Kommunikationsnetze -             AIM.  ralfpostfix
