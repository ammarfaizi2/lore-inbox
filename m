Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273989AbRISC5I>; Tue, 18 Sep 2001 22:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273991AbRISC47>; Tue, 18 Sep 2001 22:56:59 -0400
Received: from apollo.wizard.ca ([204.244.205.22]:55052 "HELO apollo.wizard.ca")
	by vger.kernel.org with SMTP id <S273989AbRISC4o>;
	Tue, 18 Sep 2001 22:56:44 -0400
Subject: Re: Linux 2.4.10-pre11
From: Michael Peddemors <michael@wizard.ca>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010918131419.A14526@turbolinux.com>
In-Reply-To: <Pine.GSO.4.21.0109181354470.27125-100000@weyl.math.psu.edu>
	<Pine.LNX.4.33.0109181122550.9711-100000@penguin.transmeta.com> 
	<20010918131419.A14526@turbolinux.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 18 Sep 2001 19:59:10 -0700
Message-Id: <1000868350.1601.42.camel@mistress>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ummmm.. because the 2.4 series is supposed to be the stable series.. and
a lot of people's comments on virtually every 2.4 kernel have expressed
dissatisfaction with it's stability..

So a lot of people haven't left the 2.2 series yet, and are waiting for
a 2.4 series that everyone is happy with..  Even in your note, you
haven't indicated a release 2.4 version that makes you happy.

On Tue, 2001-09-18 at 12:14, Andreas Dilger wrote:
> On Sep 18, 2001  11:27 -0700, Linus Torvalds wrote:
> > I agree that the timing may leave something to be desired. But we had the
> > discussion about fixing pagecache-bdev consistency wrt the regular buffer
> > cache filesystem accesses a week or so ago, and the fact is that nobody
> > really seems to have started working on it - because everybody felt that
> > you have to get everything done at once.
> 
> The real question is why can't we just open 2.5 and only fix the VM to
> start with?  Leave the kernel at 2.4.10-pre10, and possibly use the -ac
> VM code (which has diverged from mainline), and leave people (Alan, Ben,
> Marcello, et. al.) who want to tinker with it in small increments and
> do the drastic stuff in 2.5.

> 
-- 
"Catch the Magic of Linux..."
--------------------------------------------------------
Michael Peddemors - Senior Consultant
LinuxAdministration - Internet Services
NetworkServices - Programming - Security
Wizard IT Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604)589-0037 Beautiful British Columbia, Canada

