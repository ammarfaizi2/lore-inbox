Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbUARS3u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 13:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUARS3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 13:29:50 -0500
Received: from gprs214-240.eurotel.cz ([160.218.214.240]:640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262792AbUARS3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 13:29:33 -0500
Date: Sun, 18 Jan 2004 19:29:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Software Suspend Core Patch 2.0 rc4.
Message-ID: <20040118182926.GA215@elf.ucw.cz>
References: <1074282072.5328.52.camel@laptop-linux> <pan.2004.01.16.21.35.02.327622@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.01.16.21.35.02.327622@dungeon.inka.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> including urls might be nice.
> 
> also the feature comparison webpage
> does not mention bios at all.
> Till now I used SOFTWARE_SUSPEND because
> it works fine, whereas PM_DISK somehow uses the 
> bios, and does not work (dell latitude c600,

Its simple bug somewhere in PM_DISK code... it should not use the
bios...

> SWSUSP2 will be like SWSUSP concerning this issue?

Yes.

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
