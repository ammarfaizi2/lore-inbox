Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269228AbTGJMGG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 08:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269237AbTGJMGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 08:06:06 -0400
Received: from mail.ithnet.com ([217.64.64.8]:11281 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S269228AbTGJMGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 08:06:00 -0400
Date: Thu, 10 Jul 2003 14:20:22 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: green@namesys.com, mason@suse.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
Message-Id: <20030710142022.0fe83929.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.55L.0307100852230.7857@freak.distro.conectiva>
References: <20030706183453.74fbfaf2.skraw@ithnet.com>
	<1057515223.20904.1315.camel@tiny.suse.com>
	<20030709140138.141c3536.skraw@ithnet.com>
	<1057757764.26768.170.camel@tiny.suse.com>
	<20030709134837.GJ18307@namesys.com>
	<20030709141111.GK18307@namesys.com>
	<20030709162535.175d5fd3.skraw@ithnet.com>
	<Pine.LNX.4.55L.0307091408340.26373@freak.distro.conectiva>
	<20030710132141.65a8f770.skraw@ithnet.com>
	<Pine.LNX.4.55L.0307100852230.7857@freak.distro.conectiva>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul 2003 08:54:02 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> > If you want me to try others, just send them to me like these three.
> 
> Stephan,
> 
> First of all, thanks a lot for your help. Not everyone is willing to
> debug/test problems like you do. This is very important for us.
> 
> Well, we now know reiserfs patches in 2.4.22-pre are not the problem.
> 
> 2.4.21 is OK (does not crash when mounting) correct?

Everything up to and including 2.4.22-pre2 is working without problems.
Under 2.4.22-pre3 I can reiserfsck the partition and see i/o going on for
minutes without troubles.
But I cannot mount it, the box completely hangs about 1 second after mount try.
I see the drive leds blinking shortly and that's it.

Regards,
Stephan


