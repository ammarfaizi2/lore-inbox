Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269412AbTGUIqz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 04:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269439AbTGUIqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 04:46:55 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:65194 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S269412AbTGUIqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 04:46:54 -0400
Date: Mon, 21 Jul 2003 11:01:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Jan Rychter <jan@rychter.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: [Swsusp] 2.5 suspend.c changes ahead
Message-ID: <20030721090135.GA328@elf.ucw.cz>
References: <20030708233507.GB140@elf.ucw.cz> <200307091940.52781.mflt1@micrologica.com.hk> <20030709181830.GA355@elf.ucw.cz> <m2u19rau8v.fsf@tnuctip.rychter.com> <20030720111041.GA305@elf.ucw.cz> <1058700016.1705.4.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058700016.1705.4.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Longer term, I don't want them to be entirely different beasts. Once I
> get swapfile support working for 2.4, I have no plans for further
> development. I plan that my next task will be to port it to 2.5/6, and
> then begin to seek to merge it with Pavel, Andrew or whoever will take
> patces as far as they are willing.

Yes, that's welcome. BTW if you have any changes outside
kernel/suspend.c, you might want to submit them ASAP. That is, any
needed *patches* and/or bugfixes.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
