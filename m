Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286137AbSAMPYQ>; Sun, 13 Jan 2002 10:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286238AbSAMPYI>; Sun, 13 Jan 2002 10:24:08 -0500
Received: from lilly.ping.de ([62.72.90.2]:32262 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S285745AbSAMPXu>;
	Sun, 13 Jan 2002 10:23:50 -0500
Date: 13 Jan 2002 16:18:23 +0100
Message-ID: <20020113161823.B1439@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: yodaiken@fsmlabs.com
Cc: "Andrea Arcangeli" <andrea@suse.de>, "Robert Love" <rml@tech9.net>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        "Rob Landley" <landley@trommello.org>,
        "Andrew Morton" <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <20020112095209.A5735@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20020112095209.A5735@hq.fsmlabs.com>; from yodaiken@fsmlabs.com on Sat, Jan 12, 2002 at 09:52:09AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 09:52:09AM -0700, yodaiken@fsmlabs.com wrote:
> On Sat, Jan 12, 2002 at 04:07:14PM +0100, jogi@planetzork.ping.de wrote:
> > I did my usual compile testings (untar kernel archive, apply patches,
> > make -j<value> ...
> 
> If I understand your test, 
> you are testing different loads - you are compiling kernels that may differ
> in size and makefile organization, not to mention different layout on the
> file system and disk.

No, I use a script which is run in single user mode after a reboot. So
there are only a few processes running when I start the script (see
attachment) and the jobs should start from the same environment.

> What happens when you do the same test, compiling one kernel under multiple
> different kernels?

That is exactly what I am doing. I even try to my best to have the exact
same starting environment ...

Regards,

   Jogi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
