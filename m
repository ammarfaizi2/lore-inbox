Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291236AbSBXUq4>; Sun, 24 Feb 2002 15:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291214AbSBXUqp>; Sun, 24 Feb 2002 15:46:45 -0500
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:55507 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S291236AbSBXUql>;
	Sun, 24 Feb 2002 15:46:41 -0500
Date: Sun, 24 Feb 2002 20:45:13 +0000
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [PATCH] IDE clean 12 3rd attempt
Message-ID: <20020224204513.A32303@fenrus.demon.nl>
In-Reply-To: <200202241954.g1OJsPA32151@fenrus.demon.nl> <3C7946D9.1020908@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C7946D9.1020908@evision-ventures.com>; from dalecki@evision-ventures.com on Sun, Feb 24, 2002 at 09:02:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 09:02:33PM +0100, Martin Dalecki wrote:
> > 
> > it was about the i386 architecture, not just 80386 cpus. And yes 2.4 still
> > runs on those; you'be surprised how many
> > embedded systems run 80386 equivalents...
> 
> Interresting. But do they still incorporate ST509 and other
> archaic controllers? Or do they have broken BIOS-es which don't
> setup the geometry information properly? I don't think so.

You bet that embedded systems use controllers that emulate archaic ones.
Oh and bios.... well...... 

> Well now I'm quite convinced. We can point those people to the legacy
> single host driver anyway... And then the tradeoff goes just in favour
> of supporting more and more common new hardware - it will just make
> more people happy than it will make people loose :-).

If you drop hardware support for no good reason.... you scare me. you
really do. Now dropping hardware support (or moving support
elsewhere) isn't always avoidable, but I'd think you need a pretty
good reason to do so. 
