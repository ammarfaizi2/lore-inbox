Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281609AbRK0RHD>; Tue, 27 Nov 2001 12:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281663AbRK0RG7>; Tue, 27 Nov 2001 12:06:59 -0500
Received: from web9203.mail.yahoo.com ([216.136.129.26]:19852 "HELO
	web9203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281609AbRK0RGq>; Tue, 27 Nov 2001 12:06:46 -0500
Message-ID: <20011127170644.123.qmail@web9203.mail.yahoo.com>
Date: Tue, 27 Nov 2001 09:06:44 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: 'spurious 8259A interrupt: IRQ7'
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have a tulip card in my machine, and I still
have the problem. I only have spurious ints. with my
Athlon-based systems: my Intel-based machines don't
exhibit them. I think we should compile a list of boards
that have the problem and try to find some commonality.

-Alex

Martin A. Brooks" schrieb:
> 
> > As far as I remember this was talked about earlier. Different mobos,
> > chipsets, processor brands, but always IRQ 7. /me wonders.
> 
> In my research before posting, a common thread seemed to be the presence of
> a tulip card in the machine.  Has anyone seen this on a non-tulip box?
> 


__________________________________________________
Do You Yahoo!?
Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
