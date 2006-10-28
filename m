Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWJ1G32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWJ1G32 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 02:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWJ1G32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 02:29:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33194 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750943AbWJ1G30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 02:29:26 -0400
Date: Sat, 28 Oct 2006 02:29:21 -0400
From: Dave Jones <davej@redhat.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Steven Truong <midair77@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Machine Check Exception on dual core Xeon
Message-ID: <20061028062921.GA27101@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Randy Dunlap <rdunlap@xenotime.net>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	Steven Truong <midair77@gmail.com>, linux-kernel@vger.kernel.org
References: <28bb77d30610171634l5db9d909v2c4cd12972e9d5@mail.gmail.com> <90DB029B-222B-4D0C-8642-913CD81D5C9B@mac.com> <20061021033049.GC17706@redhat.com> <20061027222752.5560ad81.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061027222752.5560ad81.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 10:27:52PM -0700, Randy Dunlap wrote:
 > On Fri, 20 Oct 2006 23:30:49 -0400 Dave Jones wrote:
 > 
 > >  > You missed the blatantly obvious error message:
 > >  > "This is not a software problem!"
 > >  > 
 > >  > Immediately followed by:
 > >  > "contact your hardware vendor"
 > >  > 
 > >  > Please follow that advice
 > > 
 > > Maybe someone needs to implement <blink> tags for printk ;-)
 > 
 > oops, I didn't do it for MCEs.. :)
 > and I used reverse video since I dislike blinking.
 > 
 > photo:  http://www.xenotime.net/linux/doc/kernel-msg-hilite.jpg

Oh my.  People take me seriously far too often :-)
Could be handy for some frequently ignored bits of text
(like that mce msg), but if this gets overused it just looks
like a horrible mess imo.

Now I'm just waiting for someone to go one step further
and make openbsd style 'white on blue' kernel text ;)

	Dave

-- 
http://www.codemonkey.org.uk
