Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278405AbRJMUoe>; Sat, 13 Oct 2001 16:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278406AbRJMUoX>; Sat, 13 Oct 2001 16:44:23 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:19638
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S278405AbRJMUoG>; Sat, 13 Oct 2001 16:44:06 -0400
Date: Sat, 13 Oct 2001 13:44:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Mike Borrelli <mike@nerv-9.net>,
        linux-kernel@vger.kernel.org
Subject: Re: No love for the PPC
Message-ID: <20011013134413.A15110@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <Pine.LNX.4.21.0110121002200.13818-100000@asuka.nerv-9.net> <200110130452.f9D4qG9288830@saturn.cs.uml.edu> <20011013114729.D16500@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011013114729.D16500@mikef-linux.matchmail.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 11:47:29AM -0700, Mike Fedyk wrote:
> On Sat, Oct 13, 2001 at 12:52:16AM -0400, Albert D. Cahalan wrote:
> > Mike Borrelli writes:
> > > Anyway, the real question is, why does the ppc arhitecture /always/ break
> > > between versions?
> > 
> > At the most recent Ottata Linux Symposium, there was a PowerPC
> > session with about 20 people. Somebody did a poll, asking what
> > people used. I was the only person who dared to use a kernel
> > from Linus. Everone else was using the BenH and BitKeeper ones.
> > 
> > This is a sorry state of affairs. 
> 
> Actually, this is normal for new ports on Linux.  PPC is relatively new,
> m68k is developed with their own cvs, as is Intel IA64.  I'm sure others
> will be able to quote about other arches...

Actually, this is a normal state of affairs for !i386.  PPC has actually
been around in some form or another for 5 years almost... (at least?).
m68k is older than that.  It's sort of a given that the Linus tree will
be a bit behind.  But as far as PPC goes, we were actually pretty close
in 2.4.10 and 2.4.12 and the stable PPC tree had very few (and for the
most part unimportant) differences.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
