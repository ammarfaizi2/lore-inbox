Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283429AbRLDUKK>; Tue, 4 Dec 2001 15:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283353AbRLDUIY>; Tue, 4 Dec 2001 15:08:24 -0500
Received: from zero.tech9.net ([209.61.188.187]:51460 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281664AbRLDUHj>;
	Tue, 4 Dec 2001 15:07:39 -0500
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
From: Robert Love <rml@tech9.net>
To: Edward Muller <emuller@learningpatterns.com>
Cc: =?ISO-8859-1?Q?Ra=FAlN=FA=F1ez?= de Arenas Coronado 
	<raul@viadomus.com>,
        esr@thyrsus.com, linux-kernel@vger.kernel.org
In-Reply-To: <1007495452.4621.7.camel@akira.learningpatterns.com>
In-Reply-To: <E16BKL5-0001yJ-00@DervishD.viadomus.com> 
	<1007495452.4621.7.camel@akira.learningpatterns.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 04 Dec 2001 15:07:14 -0500
Message-Id: <1007496450.16169.20.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-12-04 at 14:50, Edward Muller wrote:

> I've put python on my Compaq IPAQ (running linux) and with very few
> amounts of tweaks it took up less 1 MB. And that's including gtk
> bindings (no tk though) and just about the entire standard python
> library. Someone else tried to do this with perl and they couldn't get
> it under 3 MB IIRC. And IIRC, the current kernel build system requires
> perl (I could be wrong, I'm just a watcher on this list, not a hacker).
> So ... PYTHON IS NOT BLOATED.

No, it doesn't require Perl.  Its sh along with the standard Linux
toolset.  xconfig is Tk, but not binded to Perl.

Regardless, I don't look at bloat as the issue -- who configures and
compiles their kernel on an embedded device?  More specifically, it is
what the kernel hackers have available and want to use that is the
requirement.  This is partly why the whole "now your mom can easily
configure her kernel" is a bs argument to me.  Forget my mom..._I_ want
things a certain way.  My mom, if I ever forc^H^H^H^H get her to use
Linux, will surely use the distro's kernel.

	Robert Love

