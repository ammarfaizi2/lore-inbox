Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbUBOPsC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 10:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbUBOPsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 10:48:02 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:5101 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264974AbUBOPr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 10:47:59 -0500
Date: Sun, 15 Feb 2004 16:47:56 +0100
From: Michael Meskes <michael@fam-meskes.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Michael Meskes <michael@fam-meskes.de>,
       Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: atkbd.c: Unknown key released/psmouse
Message-ID: <20040215154756.GA5629@trantor.fam-meskes.de>
References: <20040214143410.GA2334@1> <20040214152127.GA397@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040214152127.GA397@ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:da5cff6069dd6897c77170232368d0ba
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 04:21:27PM +0100, Vojtech Pavlik wrote:
> Please try eith 2.6.3-rc, there was a bug in 2.6.2 in i8042.c that could
> cause all kinds of errors like this.

I just tried -rc2 and -rc3 to no avail. The situation remains the same.
And I do not know enough about the serial input stuff to debug it
myself. I'm willing to try what you ask me to.

Michael
-- 
Michael Meskes
Email: Michael at Fam-Meskes dot De
ICQ: 179140304, AIM/Yahoo: michaelmeskes, Jabber: meskes@jabber.org
Go SF 49ers! Go Rhein Fire! Use Debian GNU/Linux! Use PostgreSQL!
