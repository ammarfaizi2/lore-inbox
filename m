Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261739AbSIXRl0>; Tue, 24 Sep 2002 13:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSIXRlF>; Tue, 24 Sep 2002 13:41:05 -0400
Received: from web40509.mail.yahoo.com ([66.218.78.126]:53577 "HELO
	web40509.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261723AbSIXReB>; Tue, 24 Sep 2002 13:34:01 -0400
Message-ID: <20020924173910.9940.qmail@web40509.mail.yahoo.com>
Date: Tue, 24 Sep 2002 10:39:10 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: scsi error.
To: jbradford@dial.pipex.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209241609.g8OG9deO000280@darkstar.example.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh, I forgot to mention that none of my drives were supplying term power.

I believe I'm using a high quality cable: the wires between the connectors
are braided; it only about two feet long.

I have an LVD/SE terminator on the last connector.

As for parity, the drive doesn't have a parity jumper on it. I'll assume that
parity is enabled.

BTW, it is really difficult to find the small jumpers these newer drives need.
Especially since a lot of online resellers sell the drive only, with no accessories.

Thanks for your input.

-Alex

--- jbradford@dial.pipex.com wrote:
> Hmmm, that is a bit strange - you don't specifically need to enable term power on the last
> device on the chain - both ends have to be terminated, but any device can supply the termination
> power to the bus, and only one device needs to do that> 
> John.


__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
