Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbUA0FZO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 00:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbUA0FZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 00:25:14 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:15321 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S261890AbUA0FZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 00:25:11 -0500
Date: Tue, 27 Jan 2004 06:25:07 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: atkbd.c: Unknown key released
Message-ID: <20040127052507.GF18411@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200401261834.54450@sandersweb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200401261834.54450@sandersweb.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Sanders <linux@sandersweb.net>:

> I keep getting the following in my syslog whenever I startx:

Which hardware?
 
> Jan 26 13:43:56 debian kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> Jan 26 13:43:56 debian kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> Jan 26 13:43:57 debian kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> Jan 26 13:43:57 debian kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
> 
> I don't get the error with the 2.4.24 kernel.

Same here.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
Referat V a - Kommunikationsnetze -             AIM.  ralfpostfix
