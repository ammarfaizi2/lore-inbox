Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbTGGTug (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 15:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbTGGTuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 15:50:35 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:43138 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266149AbTGGTub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 15:50:31 -0400
Date: Mon, 7 Jul 2003 21:14:06 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307072014.h67KE6FX001992@81-2-122-30.bradfords.org.uk>
To: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre3-ac1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We now have a working framework for plugging add on modules into audio
> codecs with funny features - be that modules for flipping connections
> around or stuff like the touchscreen interface.

Does flipping connections around include things like boards which have
mic in, line in, and line out, configurable as 4 and 6-channel
outputs?

(Hmmm, with 6-channel output, SMP kernel oopses in morse code will be
even better than before :-). )

John.
