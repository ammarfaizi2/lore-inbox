Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbTGBLgm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 07:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbTGBLgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 07:36:42 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:48768 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264928AbTGBLgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 07:36:41 -0400
Date: Wed, 2 Jul 2003 12:59:35 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307021159.h62BxZmV000631@81-2-122-30.bradfords.org.uk>
To: david+powerix@blue-labs.org, pavel@ucw.cz
Subject: Re: laptop w/ external keyboard misprint FYI
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Kernel 2.5.73, first time I've used an external keyboard
> > 
> > When I plug my external Logitech keyboard into my laptop, (shared 
> > keyboard/mouse port), dmesg output indicates a generic mouse was 
> > attached instead of a keyboard.  The keyboard works, it's just the 
> > dmesg info that's inaccurate.
>
> Well, you have plugged keyboard into
> *mouse* port. Its small miracle it works ;), and
> it probably will not work in LILO. You
> should use Y cabel and plug keyboard there.

A keyboard should work fine, (in any recent 2.5 Linux kernel), plugged
in to the AUX port, and it should identify it as a keyboard.  I've
tested this, and it worked fine for me.

John.
