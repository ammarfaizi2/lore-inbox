Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272159AbTHEMYB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272681AbTHEMYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:24:01 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:25236 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272159AbTHEMX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:23:57 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 14:23:55 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: decoded problem in 2.4.22-pre10
Message-Id: <20030805142355.74eba27b.skraw@ithnet.com>
In-Reply-To: <9433E945C9B@vcnet.vc.cvut.cz>
References: <9433E945C9B@vcnet.vc.cvut.cz>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 14:02:38 +0200
"Petr Vandrovec" <VANDROVE@vc.cvut.cz> wrote:

> On  5 Aug 03 at 12:20, Stephan von Krawczynski wrote:
> > On Tue, 5 Aug 2003 10:00:40 +0200
> > Stephan von Krawczynski <skraw@ithnet.com> wrote:
> > 
> > > Hello all,
> > > 
> > > the testbox crashed again this night, unfortunately I made a mistake
> > > yesterday and started vmware once. Although only the usual modules were
> > > loaded at crash time and not the application, the kernel was tainted of
> > > course. Nevertheless I present the data:
> > 
> > I re-checked the setup with vmware and found out I can shoot it down in no
> > time. So you probably should just forget about this bug report, because
> > loading vmware modules does obviously do harm.
> 
> Any details? Were there some warning while vmmon was built?
>                                                             Petr

Hello Petr,

at this time I can't provide you with details or exact reporting as the box has
to be used for finding the 2.4.22-pre stability problem I see. And since the
crashes take quite some time to occur I cannot reboot and check out what's the
deal with the vmware modules.
And frankly: I find the application quite ok but tainting the kernel with the
closed source modules is really something to think about, especially since
there should be easy ways to avoid that completely.
Btw I already stopped using nvidia equipment completely due to not being able
to produce valuable debugging output while running an nvidia-tainted kernels.

I might come back to your request for details when 2.4.22 got stable.

Regards,
Stephan



