Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263399AbUDYUq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbUDYUq2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 16:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUDYUq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 16:46:28 -0400
Received: from gprs214-24.eurotel.cz ([160.218.214.24]:54403 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263399AbUDYUqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 16:46:24 -0400
Date: Sun, 25 Apr 2004 22:46:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Cc: ncunningham@linuxmail.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: fix error handling in "not enough swap space"
Message-ID: <20040425204611.GH24375@elf.ucw.cz>
References: <4089DC36.5020806@pointblue.com.pl> <opr6xykbzqruvnp2@laptop-linux.wpcb.org.au> <4089E761.5050708@pointblue.com.pl> <opr6x0o10uruvnp2@laptop-linux.wpcb.org.au> <4089F0E5.3050006@pointblue.com.pl> <20040424183505.GB2525@elf.ucw.cz> <408B5F5B.1090802@pointblue.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408B5F5B.1090802@pointblue.com.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >That's bad. That's even without swsusp, right? Again, test on 2.6.5
> >and post test case. Something is probably wrong in 2.6.6-bk. 
> > 
> >
> Yes, it is working fine on 2.6.5. I can investigate my self in spare 
> time. If you have any ideas, hints, or test procedures I can follow, 
> tell me. I know C very good.

Try get akpm's attetion, send him your test program. I'm not mm/ guru,
he'll probably point you to a good starting place (or probably fix it
himself quickly).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
