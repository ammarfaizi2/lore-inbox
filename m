Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbUA0RKs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 12:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUA0RKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 12:10:48 -0500
Received: from smtp10.hy.skanova.net ([195.67.199.143]:42463 "EHLO
	smtp10.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261837AbUA0RKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 12:10:46 -0500
Date: Tue, 27 Jan 2004 18:10:43 +0100 (CET)
Message-Id: <200401271710.i0RHAhv26675@d1o408.telia.com>
From: "Voluspa" <lista3@comhem.se>
Reply-To: "Voluspa" <lista3@comhem.se>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: atkbd.c: Unknown key released
X-Mailer: Telia Webmail
X-Telia-webmail-clientstamp: [217.208.132.234] 2004-01-27 18:10:43
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

citerar Vojtech Pavlik:

> On Tue, Jan 27, 2004 at 08:16:59AM +0100, Voluspa wrote:
[...]
>
> > > > I keep getting the following in my syslog whenever I startx:
> >
> > In fact, it is preemptively written even _before_ I start X :-)
[...]
> Do you use 'kbdrate' in your bootup scripts? That's another one touching
> the keyboard controller directly, when there are ioctls for that.
>
> I guess I should modify to make the message not point not directly to X,
> but 'some application'.

Yes, 'kbdrate' is used here.

Mvh
Mats Johannesson

