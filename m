Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTLUOaq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 09:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTLUOaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 09:30:46 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3456 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263101AbTLUOap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 09:30:45 -0500
Date: Sun, 21 Dec 2003 14:36:37 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200312211436.hBLEab6c000304@81-2-122-30.bradfords.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: ryutaroh@it.ss.titech.ac.jp, vojtech@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20031221112316.GE3438@mail.shareable.org>
References: <20031219123645.GA28801@ucw.cz>
 <20031220.183049.74735752.ryutaroh@it.ss.titech.ac.jp>
 <20031220093532.GB6017@ucw.cz>
 <20031220.185244.71103628.ryutaroh@it.ss.titech.ac.jp>
 <200312201246.hBKCkP4a000191@81-2-122-30.bradfords.org.uk>
 <20031221112316.GE3438@mail.shareable.org>
Subject: Re: [PATCH] cannot input bar with JP106 keyboards
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On the Linux console, all combinations generate a broken vertical
> line, although that's the terminal font displaying a broken line for
> the same character that X shows as a solid one.

Yeah, fonts often use the 'wrong' glyphs, although I'd hazard a guess
that there is now no 'official' glyph for the traditional ASCII pipe
character, and that Unicode probably also defines separate solid
vertical bar and broken vertical bar characters outside the 0 - 127
range.

John.
