Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTEYMfD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 08:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTEYMfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 08:35:03 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:21509 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262066AbTEYMfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 08:35:02 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Stephan von Krawczynski <skraw@ithnet.com>,
       Willy Tarreau <willy@w.ods.org>
Subject: Re: Undo aic7xxx changes
Date: Sun, 25 May 2003 14:47:56 +0200
User-Agent: KMail/1.5.1
Cc: willy@w.ods.org, gibbs@scsiguy.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <20030524111608.GA4599@alpha.home.local> <20030525125811.68430bda.skraw@ithnet.com>
In-Reply-To: <20030525125811.68430bda.skraw@ithnet.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305251447.34027.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 May 2003 12:58, Stephan von Krawczynski wrote:

Hi Stephan,

> Though I used nmi_watchdog there are no presentable outputs. As I expected
> the screen simply is black and no messages are in any logfiles.
> Again it froze while tar-ing about 80 GB of data onto an aic-driven SDLT.
> Data is coming from IDE drive connected to a 3ware 7500-8 (though no raid
> configuration).
>
> I conclude that rc2+aic20030502 was way better.
> Ah yes, one more thing: I can ping the box, but keyboard, mouse, display is
> dead and usually working processes stopped (like snmp).
> Willy: I am willing to try a serial console setup (as it does not interfere
> with X). I have tried this before with no luck. Can you provide some hints
> how you got that working (yes, I read Documentation/serial-console.txt, but
> I could not manage any output on the serial line).
before trying this, could you please update to aic20030523? Thank you.


ciao, Marc
