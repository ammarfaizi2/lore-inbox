Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbTEQPy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 11:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTEQPy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 11:54:26 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:65420 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261603AbTEQPyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 11:54:25 -0400
Date: Sat, 17 May 2003 18:05:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: M?ns Rullg?rd <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What exactly does "supports Linux" mean?
Message-ID: <20030517160509.GA283@elf.ucw.cz>
References: <20030514021210.GD30766@pegasys.ws> <BKEGKPICNAKILKJKMHCAMEONCPAA.Riley@Williams.Name> <yw1xhe7xo1f6.fsf@zaphod.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xhe7xo1f6.fsf@zaphod.guide>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  > Linux compatible:
> >  >     Source code driver is available as a patch.
> > 
> > In other words, if a patch is available for the 1.0.0 kernel, they
> > can claim "Linux compatible" ??? That's meaningless...replace with
> > something like...

Yep, I guess patch for 1.0.0 kernel would count as Linux compatible. I
even believe that patch for FreeBSD would count as Linux
compatible. As long as you can get source of the driver, it is easy.

Maybe better sticker would be

"includes driver sources".

[Long time ago I got double-speed cdrom, and on its driver disk, there
was C source of the driver. Porting it to linux was matter of two
days, IIRC. And it had korean comments ;-)].
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
