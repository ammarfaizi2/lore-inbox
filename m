Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272040AbTGYMQH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 08:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272041AbTGYMQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 08:16:07 -0400
Received: from www.13thfloor.at ([212.16.59.250]:27525 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272040AbTGYMQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 08:16:05 -0400
Date: Fri, 25 Jul 2003 14:31:22 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Catalin BOIE <util@deuroconsult.ro>
Cc: Manjunathan Padua Yellappan <manjunathan_py@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.0-test1 refuses to boot on a PC with AMD Athlon XP 1800+ (another one)
Message-ID: <20030725123122.GB15999@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Catalin BOIE <util@deuroconsult.ro>,
	Manjunathan Padua Yellappan <manjunathan_py@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20030725065507.26549.qmail@web14208.mail.yahoo.com> <Pine.LNX.4.53.0307251012230.1571@hosting.rdsbv.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307251012230.1571@hosting.rdsbv.ro>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 10:14:28AM +0300, Catalin BOIE wrote:
> > Hi Folks,

> > I compiled the latest version of the kernel
> > 2.6.0-test1.
> >
> > My Machine just stops after displaying the following
> >
> >     "Uncompressing Linux... Ok, booting the kernel "
> >
> > Nothing happens after this message, it just hangs
> 
> Exactly same problem here, two machines. So this is making us 3. :)

I observed such behaviour when the Processor Type didn't
match the actual hardware ... I do not assume that you
configured the wrong Processor, but IMHO it could be
possible that the selected Type doesn't match on those
systems ... therefor I would suggest to try with 386
just for the fun of doing it ...

HTH,
Herbert

> Any ideas?
> Thanks!
> >
> > Please assist me in solving this, I am very keen on to
> > testing this kernel.
