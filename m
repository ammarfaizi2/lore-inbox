Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263660AbTLAROt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 12:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTLAROt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 12:14:49 -0500
Received: from gprs144-162.eurotel.cz ([160.218.144.162]:43392 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263660AbTLAROs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 12:14:48 -0500
Date: Mon, 1 Dec 2003 18:15:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [RFC/PATCH 1/3] Input: resume support for i8042 (atkbd & psmouse)
Message-ID: <20031201171537.GC377@elf.ucw.cz>
References: <200312010215.58533.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312010215.58533.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here is an attempt to implement resume for i8042 using serio_reconnect
> facility that can be found in -mm kernels. It also depends on bunch of 
> other changes in input subsystem all of which can be found here:
> http://www.geocities.com/dt_or/input
> 
> They should apply cleanly to -test11.

It looks very reasonable to me... I'd like it to be in 2.6.1... or
even better 2.6.0.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
