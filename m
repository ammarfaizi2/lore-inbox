Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263621AbTDTQHD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 12:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTDTQHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 12:07:03 -0400
Received: from mail.ithnet.com ([217.64.64.8]:25871 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263621AbTDTQHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 12:07:02 -0400
Date: Sun, 20 Apr 2003 18:18:12 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
Subject: Re: ISDN massive packet drops while DVD burn/verify
Message-Id: <20030420181812.44844175.skraw@ithnet.com>
In-Reply-To: <1050789691.3955.17.camel@dhcp22.swansea.linux.org.uk>
References: <20030416151221.71d099ba.skraw@ithnet.com>
	<Pine.LNX.4.44.0304161056430.5477-100000@chaos.physics.uiowa.edu>
	<20030419193848.0811bd90.skraw@ithnet.com>
	<1050789691.3955.17.camel@dhcp22.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Apr 2003 23:01:32 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Sad, 2003-04-19 at 18:38, Stephan von Krawczynski wrote:
> > I don't buy that explanation. Reason is simple: during this all network
> > connections work flawlessly, and they do have quite a lot of interrupts
> > compared to ISDN. ISDN is so slow and has so few interrupts that it is
> > quite unlikely in a SMP-beyond-GHz-limit box that you loose some. The
> > ancient hardware days are long gone ...
> 
> I'd suggest buying his explanation, because he's right. You are
> confusing quantity and latency.

Sorry Alan, "been there, done that"
I made ISDN work on just about anything that you would call an OS on sometimes
quite ancient hardware (compared to nowadays), and I really cannot imagine that
the combined (though sometimes confusing) efforts of you, Andre, Pavel, name-one
on IDE made a dual 1.4 GHz PIII slower (responding) than a M68k 7,14 MHz with a
polling IDE interface - which happens to be the slowest thing I ever did ISDN
programming on _flawlessly_.

Regards,
Stephan
