Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265537AbTFZKgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 06:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265540AbTFZKgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 06:36:49 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:10988 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265537AbTFZKgs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 06:36:48 -0400
Date: Thu, 26 Jun 2003 12:50:19 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Tim McGrath <misty-@charter.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problems with IDE on GA-7VAXP motherboard
In-Reply-To: <1056613389.323.1.camel@roll>
Message-ID: <Pine.SOL.4.30.0306261242310.24845-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 26 Jun 2003, Tim McGrath wrote:

> Well, I just rebooted and checked - I can, in fact, set the CHS
> settings. However, not to the settings I need. ... Which explains nicely
> why my bios can't figure out what to do with my disk. Ah well, I tried.
>
> Anyone with suggestions on how to get DOS booting and happy would be
> appreciated.

Maybe you can use dosemu under Linux instead?
http://www.dosemu.org

There is also GPLed DOS replacement, maybe it doesn't use CHS info,
if it does you have source code available ;-).
http://www.freedos.org

--
Bartlomiej

> Tim McGrath

