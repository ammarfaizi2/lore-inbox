Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284609AbRLIXFT>; Sun, 9 Dec 2001 18:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284611AbRLIXFJ>; Sun, 9 Dec 2001 18:05:09 -0500
Received: from hermes.toad.net ([162.33.130.251]:51144 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S284609AbRLIXEy>;
	Sun, 9 Dec 2001 18:04:54 -0500
Subject: Re: APM woes: IBM T20 Thinkpad
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Alex Hudson <home@alexhudson.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 09 Dec 2001 18:06:10 -0500
Message-Id: <1007939172.930.2.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try installing a new battery.

> I've also seen a couple of other apm-wierdos - the battery
> being at 99% full even after being on the charger for a while

This isn't necessarily abnormal.  The firmware may be 
switching off the charger when the battery is close
to full, in order to preserve battery life.



