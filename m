Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVGGSpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVGGSpl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 14:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVGGSpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 14:45:41 -0400
Received: from web32605.mail.mud.yahoo.com ([68.142.207.232]:19108 "HELO
	web32605.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261552AbVGGSpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 14:45:39 -0400
Message-ID: <20050707184538.15647.qmail@web32605.mail.mud.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Thu, 7 Jul 2005 11:45:38 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: [Hdaps-devel] RE: Head parking (was: IBM HDAPS things are looking up)
To: Dave Hansen <dave@sr71.net>
Cc: abonilla@linuxwireless.org, "'Pekka Enberg'" <penberg@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de,
       "'Pekka Enberg'" <penberg@cs.helsinki.fi>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
In-Reply-To: <1120757693.5829.34.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Dave Hansen <dave@sr71.net> wrote:

> On Thu, 2005-07-07 at 10:14 -0700, Martin Knoblauch wrote:
> >  Basically I saw that the only difference between me and Pekka was
> the
> > FW (discounting the different CPU speed and Kernel version). I
> googled
> > around and found the IBM FW page at:
> > 
> >
>
http://www-306.ibm.com/pc/support/site.wss/document.do?sitestyle=ibm&lndocid=MIGR-41008
> > 
> >  Download is simple, just don't use the "IBM Download Manager".
> Main
> > problem is that one needs a bootable floopy drive and "the other
> OS" to
> > create a bootable floppy. It would be great if IBM could provide
> floppy
> > images for use with "dd" for the poor Linux users.
> 
> Did you really need to make 18 diskettes?
>

 yikes - no !! :-) Somewhere on that page there is a table that tells
you which of the 18 floppies is for your disk. In my case it was #13.
 
> I have the feeling that this will work for many T4[012]p? users:
> 
>
http://www-307.ibm.com/pc/support/site.wss/document.do?lndocid=TPAD-HDFIRM
> 

 Yeah, I think that is the "DA" version. You still need "the other OS",
although you don't need the floppy.

 If IBM would provide a CD image (bootable ISO) containing FW for all
supported drives - that would be great. No need for the "other OS" any
more.

Cheers
Martin

------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
