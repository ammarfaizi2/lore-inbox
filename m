Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267627AbTAQSTc>; Fri, 17 Jan 2003 13:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267628AbTAQSTc>; Fri, 17 Jan 2003 13:19:32 -0500
Received: from [132.69.253.254] ([132.69.253.254]:57550 "HELO
	vipe.technion.ac.il") by vger.kernel.org with SMTP
	id <S267627AbTAQSTb>; Fri, 17 Jan 2003 13:19:31 -0500
Date: Fri, 17 Jan 2003 20:28:26 +0200 (IST)
From: Shlomi Fish <shlomif@vipe.technion.ac.il>
To: Sam Ravnborg <sam@ravnborg.org>
cc: David Woodhouse <dwmw2@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
In-Reply-To: <20030117180001.GA1860@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.33L2.0301172027310.25073-100000@vipe.technion.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Sam Ravnborg wrote:

> On Fri, Jan 17, 2003 at 07:00:58PM +0200, Shlomi Fish wrote:
> >
> > Do you mean I'll need a live Linux kernel to build the kernel module
> > package?
>
> Yes, you fundamentally need the full kernel to compile a module.
> Modules may refer to different headers, and some may even be arch specific.
>
> The trick dwmw2 gave you is the only _sane_ way to build a module.
>

Yes I gathered it from him and #kernelnewbies. In the future I want
CLAN to be able to package entire kernels. But I'll guess I'll cross the
bridge when I get there, and there's no need to overengineer now.

Regards,

	Shlomi Fish

> 	Sam
>



----------------------------------------------------------------------
Shlomi Fish        shlomif@vipe.technion.ac.il
Home Page:         http://t2.technion.ac.il/~shlomif/

He who re-invents the wheel, understands much better how a wheel works.

