Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277024AbRKMRMn>; Tue, 13 Nov 2001 12:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277068AbRKMRMd>; Tue, 13 Nov 2001 12:12:33 -0500
Received: from [195.63.194.11] ([195.63.194.11]:43281 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S277024AbRKMRMZ>; Tue, 13 Nov 2001 12:12:25 -0500
Message-ID: <3BF160D8.92E01A1F@evision-ventures.com>
Date: Tue, 13 Nov 2001 19:05:12 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: dalecki@evision.ag, linux-kernel@vger.kernel.org
Subject: Re: Merge BUG in 2.4.15-pre4 serial.c
In-Reply-To: <E161TWH-0004G9-00@the-village.bc.nu> <3BF14F14.21D66343@evision-ventures.com> <20011113162111.B21298@flint.arm.linux.org.uk> <3BF15A72.793A1BF2@evision-ventures.com> <20011113165354.D21298@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Tue, Nov 13, 2001 at 06:37:54PM +0100, Martin Dalecki wrote:
> > Pushing the port numbers artificially behind doesn't make sense for me
> > and makes some setserial unknown tricks neccessary for irtty setup.
> 
> The key words here are "for me".
> 
> What setserial "unknown tricks" are you referring to?

I referr to the IrDA-HOWTO problems with the serial driver I think
this may be precisely the cause of the culprit.
