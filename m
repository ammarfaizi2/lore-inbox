Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270644AbRHWWXm>; Thu, 23 Aug 2001 18:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270640AbRHWWXc>; Thu, 23 Aug 2001 18:23:32 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:20353 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S270644AbRHWWXY>; Thu, 23 Aug 2001 18:23:24 -0400
Date: Thu, 23 Aug 2001 15:23:54 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Fred <fred@arkansaswebs.com>
cc: Ajit Jena <ajit@cc.iitb.ac.in>, <linux-kernel@vger.kernel.org>
Subject: Re: Quantum DLT 4000 issues
In-Reply-To: <01082313484201.12044@bits.linuxball>
Message-ID: <Pine.LNX.4.33.0108231517220.8468-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A cd-burner is hardly a replacement for a 35gb native tape format...

I'd probably run a cleaning tape through the drive a couple times to
start, try a fresh tape in the drive, isolate it on it's own scsi
interface if there are other devices connected on the same bus, and have
the drive evaluated and serviced by hp in roughly that order...

joelja

On Thu, 23 Aug 2001, Fred wrote:

> I read somewhere - recently - that 60% of ALL tape backups fail. If that's
> so, I'd recommend that you ditch the tape drive. (get a cd burner! or another
>  hard drive)
>
> Fred
>
>  _________________________________________________
> On Thursday 23 August 2001 10:52 am, Ajit Jena wrote:
> > Hi All,
> >
> > I need your expert advice on the following issue:
> >
> > I saw some messages on the Linux kernel mailing list about DLT 4000
> > tape drives.
> >
> > We have a Quantum DLT 4000 1/15 drive connected to an HP9000 system.
> > This is a SCSI device connected on the Wide SCSI port. I have all kinds
> > of driver problems on the HP system. My tar backups abort randomly saying
> > media error.
> >
> > I was wondering if I can connect the same drive to a Linux box having
> > wide SCSI interface. Do u think this is a workable proposition ? What
> > extra hardware/software I need to procure ? Please advise.
> >
> > Thanks for your time.
> >
> > Regards.
> >
> > --ajit
> >
> > |---------------------------------------------------------------------|
> > | Ajit K. Jena                          Phone :                       |
> > |                                          Office +91-22-5767751      |
> > | Computer Centre                                 +91-22-5722545 x8750|
> > | Indian Institute of Technology           Home   +91-22-5722545 x8068|
> > | POWAI, Mumbai                         Fax   :        +91-22-5723894 |
> > | PIN 400076, India                     Email :    ajit@cc.iitb.ac.in |
> > |---------------------------------------------------------------------|
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


