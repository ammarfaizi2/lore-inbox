Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265620AbRGFAIx>; Thu, 5 Jul 2001 20:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265623AbRGFAIo>; Thu, 5 Jul 2001 20:08:44 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:34062
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S265620AbRGFAIf>; Thu, 5 Jul 2001 20:08:35 -0400
Date: Thu, 5 Jul 2001 20:14:37 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Guest section DW <dwguest@win.tue.nl>
Cc: Aaron Lehmann <aaronl@vitelus.com>,
        Stephen C Burns <sburns@farpointer.net>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: LILO calling modprobe?
Message-ID: <20010705201437.A10630@animx.eu.org>
In-Reply-To: <20010705224245.A1789@win.tue.nl> <20010705140330.C22723@vitelus.com> <20010705180331.A10315@animx.eu.org> <20010706010107.A1956@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20010706010107.A1956@win.tue.nl>; from Guest section DW on Fri, Jul 06, 2001 at 01:01:07AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Is there a reason that it does this?
> > 
> > I believe there is.  It wants to find what drive is bios drive 80h.
> 
> Yes.
> 
> > I had a machine at work with both ide and scsi.  ide hdd was hdc and ide
> > cdrom was hda just to keep lilo from thinking hdc is the first bios drive
> > which infact sda was
> 
> But why don't you use the bios keyword? From lilo.conf(5):

I was only explaining.  I foundout about the bios keyword after searching. 
But I didn't have time then to do the searching and didn't care.  it worked
for me.

I don't boot scsi drives on any of my systems that also have ide.  I prefer
the systems to be either, but not both (test boxes excluded =)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
