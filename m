Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272975AbTG3Pkg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 11:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272992AbTG3Pkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 11:40:35 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2432 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272975AbTG3Pka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 11:40:30 -0400
Date: Wed, 30 Jul 2003 16:50:22 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307301550.h6UFoMf4000329@81-2-122-30.bradfords.org.uk>
To: aebr@win.tue.nl, cat@zip.com.au
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Cc: linux-kernel@vger.kernel.org, pgw99@doc.ic.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Would this (now or in the future) by any chance let one use the keyboard
> > leds for stuff without activating their num lock, caps lock and scroll
> > lock functionality? I'd like to use one of them (at least) as a network
> > traffic indicator but so far I get the sideffects of the functionality
> > being on also. Most annoying when typing. :/
>
> The use of LEDs as random lights instead of as keyboard status indicators
> has been possible since very early times. See the kernel code, or setleds(1).

The keyboard LEDs are far too slow to access to use for 'front-panel'
type applications, though.

John.
