Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266091AbTFWS7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 14:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbTFWS7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 14:59:08 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:44162 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266091AbTFWS6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 14:58:13 -0400
Date: Mon, 23 Jun 2003 20:20:23 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306231920.h5NJKNA0002045@81-2-122-30.bradfords.org.uk>
To: felipe_alfaro@linuxmail.org, helgehaf@aitel.hist.no
Subject: Re: O(1) scheduler & interactivity improvements
Cc: john@grabjohn.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Well, no, opaque window moving is fine if the CPU isn't at 100%.  If
> > > it is, I'd rather see choppy window movements than have a server
> > > application starved of CPU.  That's just my preference, though.
> > > 
> > That could be an interesting hack to a window manager -
> > don't start the move in opaque mode when the load is high.
>
> But there are so many window managers floating out there...

True, but FVWM is obviously the best :-).

John.
