Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUDGOoJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbUDGOoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:44:09 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:41917 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S263685AbUDGOoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:44:06 -0400
Date: Wed, 7 Apr 2004 16:43:56 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_4KSTACKS in mm2?
Message-ID: <20040407144356.GC6842@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040407135551.GA32088@charite.de> <Pine.LNX.4.58.0404071000340.16677@montezuma.fsmlabs.com> <20040407140346.GC32088@charite.de> <Pine.LNX.4.58.0404071037341.16677@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0404071037341.16677@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zwane Mwaikambo <zwane@linuxpower.ca>:

> > That's what I did (and it works) -- but it's not really intuitive or
> > even configurable (in the way of menuconfig or something).
> 
> Andrew Morton turned it on unconditionally on purpose for wider testing.

Yep. It doesn't work with Nvidia's nvidia kernel drivers. But what's
new :)

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
