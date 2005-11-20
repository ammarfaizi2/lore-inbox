Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVKTSiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVKTSiW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 13:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVKTSiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 13:38:22 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:22161 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1750713AbVKTSiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 13:38:22 -0500
Date: Sun, 20 Nov 2005 18:14:09 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm2 unsusable on DELL Inspiron 8200, 2.6.15-rc1 works fine
Message-ID: <20051120171409.GA7285@stiffy.osknowledge.org>
References: <20051118182910.GJ6640@stiffy.osknowledge.org> <200511182207.19984.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511182207.19984.dtor_core@ameritech.net>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc1-patched-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry Torokhov <dtor_core@ameritech.net> [2005-11-18 22:07:19 -0500]:

> On Friday 18 November 2005 13:29, Marc Koschewski wrote:
> > Nov 18 12:58:37 stiffy kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
> > 
> > SOME STUFF MISSING? HUH?
> > 
> > Nov 18 13:03:14 stiffy kernel: psmouse.c: resync failed, issuing reconnect request
> > 
> 
> Hm, this worries me a bit... Could you please try appying the patch
> below to plain 2.6.15-rc1 and see if mouse starts misbehaving again?

Dmitry,

I applied the 5 patches to a plain 2.6.15-rc1. The mouse was well as if it was
in an unpatched kernel. The problem just occured in 2.6.15-rc1-mmX.
Plain 2.6.15-rc1 was fine before as well. So: actually no change.

Need any more info?

Marc
