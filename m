Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965480AbWI0Jnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965480AbWI0Jnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965483AbWI0Jnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:43:46 -0400
Received: from mx.laposte.net ([81.255.54.11]:17900 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S965480AbWI0Jnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:43:45 -0400
Message-ID: <43447.192.54.193.51.1159350218.squirrel@rousalka.dyndns.org>
Date: Wed, 27 Sep 2006 11:43:38 +0200 (CEST)
Subject: Re: GPLv3 Position Statement
From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
To: linux-kernel@vger.kernel.org
Cc: "James Bottomley" <James.Bottomley@SteelEye.com>
User-Agent: SquirrelMail/1.4.8-2.fc6
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As far as the you must be able to run modifications language goes:  too
> many embedded devices nowadays embed linux.  To demand a channel for
> modification is dictating to manufacturers how they build things.  Take
> the case of an intelligent SCSI PCI card which happens to run embedded
> linux in flash.

So just clarify GPL v3 so any GPLv3 distributor gives the same level of
access to the people he distributes his GPLed software do (ie if the code
is on a flasheable device, open the flash process ; if it's drm-protected
: give
the DRM key)

It's not as if most (all?) widespread linux-embedded devices are not
flashable nowadays. Factory recall everytime you need to fix a
security/feature bug just costs too much

(as far as I know every single Tivo-like thing *is* updateable remotely)

-- 
Nicolas Mailhot


