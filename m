Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261850AbSI2Xwt>; Sun, 29 Sep 2002 19:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261846AbSI2Xwt>; Sun, 29 Sep 2002 19:52:49 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:56558 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S261850AbSI2Xwn>; Sun, 29 Sep 2002 19:52:43 -0400
Date: Sun, 29 Sep 2002 19:58:02 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: [murrayr@brain.org: Re: v2.6 vs v3.0]
Message-ID: <20020929235802.GB17288@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Accidentally hit reply instead of list:

----- Forwarded message from "Murray J. Root" <murrayr@brain.org> -----

From: "Murray J. Root" <murrayr@brain.org>
To: Jens Axboe <axboe@suse.de>
Subject: Re: v2.6 vs v3.0
Date: Sun, 29 Sep 2002 19:55:05 -0400
User-Agent: Mutt/1.4i

On Sun, Sep 29, 2002 at 05:50:51PM +0200, Jens Axboe wrote:
> On Sun, Sep 29 2002, Murray J. Root wrote:
> > On Sun, Sep 29, 2002 at 11:12:29AM +0200, Jens Axboe wrote:
> > > On Sun, Sep 29 2002, jbradford@dial.pipex.com wrote:
> > > > > Anyway, people who are having VM trouble with the current 2.5.x series, 
> > > > > please _complain_, and tell what your workload is. Don't sit silent and 
> > > > > make us think we're good to go.. And if Ingo is right, I'll do the 3.0.x 
> > > > > thing.
> > > > 
> > > > I think the broken IDE in 2.5.x has meant that it got seriously less
> > > > testing overall than previous development trees :-(.  Maybe after
> > > > halloween when it stabilises a bit more we'll get more reports in.
> > > 
> > > 2.5 is definitely desktop stable, so please test it if you can. Until
> > > recently there was a personal show stopper for me, the tasklist
> > > deadline. Now 2.5 is happily running on my desktop as well.
> > > 
> > > 2.5 IDE stability should be just as good as 2.4-ac.
> > > 
> > Hmm - our definitions must be different.
> 
> Not necessarily, you may just have worse luck than me.
> 
> > ASUS P4S533 (SiS645DX chipset)
> > P4 2Ghz
> > 1G PC2700 RAM
> > 
> > Disable SMP, enable APIC & IO APIC
> > Get "WARNING - Unexpected IO APIC found"
> > system freezes
> > 
> > Disable IO APIC, enable ACPI
> > system detects ACPI, builds table, freezes.
> > 
> > Disable ACPI, enable ide-scsi in the kernel
> > kernel panic analyzing hdc
> > 
> > None of these have been reported because I haven't had time to do all the
> > work involved in making a report that anyone on the team will read.
> 
> But you have time to write this email and complain that it doesn't work?
> -> /dev/null, until you send proper reports.
> 
I wasn't complaining - only pointing out that it wasn't ready yet.
Writing the email took a few seconds. Getting the info for a proper bug report
takes a long time, especially considering that one omission will get this
response from you (and most other team members).
Debugging kernel's is NOT what I do with my time - just something I *thought*
would be appreciated, since my mainboard/chipset is relatively new and not
many people have it. Since only perfect reports are welcome, I'll refrain from
submitting any in the future.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.openprojects.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 


----- End forwarded message -----

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.openprojects.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

