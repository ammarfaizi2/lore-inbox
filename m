Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbRFUUQl>; Thu, 21 Jun 2001 16:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbRFUUQb>; Thu, 21 Jun 2001 16:16:31 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:48802 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S265193AbRFUUQM>; Thu, 21 Jun 2001 16:16:12 -0400
Message-ID: <3B325665.346F5AB5@idcomm.com>
Date: Thu, 21 Jun 2001 14:17:41 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Controversy over dynamic linking -- how to end the panic
In-Reply-To: <E15D9mV-0001wf-00@the-village.bc.nu> <p05100327b757fc43c456@[207.213.214.37]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell wrote:
> 
> At 8:06 PM +0100 2001-06-21, Alan Cox wrote:
> >  > > the stdio.h, I'd tell him to go screw himself.
> >>  What is the difference between including kernel header file and
> >>  including GPLed header file?
> >
> >There are real differences between programs and interface definitions. At this
> >point you get into law and the like and its probably best you read up on it
> >from a reputable source not l/k
> 
> Though header files don't fall clearly on the interface-definition
> side of the line. ctype.h, for example, in userland, or any other
> header with #defined or inline code.
> --
> /Jonathan Lundell.

Add to that the complications of C++ templates (not used in kernel, but
it could certainly test the law).
