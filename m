Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbULCRot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbULCRot (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbULCRot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:44:49 -0500
Received: from mail.linicks.net ([217.204.244.146]:47365 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S262436AbULCRor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:44:47 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: newbie kernel hacking question.
Date: Fri, 3 Dec 2004 17:44:45 +0000
User-Agent: KMail/1.7
References: <200412031715.15067.nick@linicks.net> <41B0A0BE.3070107@osdl.org>
In-Reply-To: <41B0A0BE.3070107@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412031744.46054.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 December 2004 17:22, Randy.Dunlap wrote:
> > Is it this simple just to undef this in /include/linux/pc_keyb.h
> >
> > #define KBD_REPORT_TIMEOUTS             /* Report keyboard timeouts */
> >
> > I have read code through, and it appears the right thing to do (and it's
> > so simple I am in doubt it is this easy), but I am loath to try it in
> > case the box doesn't come up and I will have to fart around getting out
> > monitor and kb and move my sofa for access and stuff...
> >
> > Thanks for any help.
>
> Yes, it looks like that should do it in Linux 2.4.x.
> The keyboard driver isn't the same in 2.6.x....

Yes, sorry, is one of my 2.4.28 boxes.

OK, I am going for it!

Thanks,

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
