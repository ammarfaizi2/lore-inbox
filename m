Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbUCTQvz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbUCTQvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:51:55 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:40065 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S262292AbUCTQvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:51:53 -0500
Date: Sat, 20 Mar 2004 17:51:49 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: badness in kernel/softirq.c
Message-ID: <20040320165149.GD15158@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1079800804.13796.5.camel@Discovery.brad-x.com> <1079800910.13796.7.camel@Discovery.brad-x.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1079800910.13796.7.camel@Discovery.brad-x.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Brad Laue <brad@brad-x.com>:

> I apparently need to be reminded to actually attach attachments. :-)

Yep. I get the very same backtrace, whenever pppoe or pppd (dunno
which) is shut down e.g. for rebooting the box.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
