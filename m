Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264071AbRFESmw>; Tue, 5 Jun 2001 14:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264072AbRFESmn>; Tue, 5 Jun 2001 14:42:43 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:13522 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S264071AbRFESmb>; Tue, 5 Jun 2001 14:42:31 -0400
Date: Tue, 5 Jun 2001 14:42:16 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: TRG vger.timpanogas.org hacked
Message-ID: <20010605144216.A18046@alcove.wittsend.com>
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	jmerkey@timpanogas.org
In-Reply-To: <20010604183642.A855@vger.timpanogas.org> <E157AuE-0006Wc-00@the-village.bc.nu> <20010605113051.A6209@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <20010605113051.A6209@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Tue, Jun 05, 2001 at 11:30:51AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2001 at 11:30:51AM -0700, Jeff V. Merkey wrote:
> On Tue, Jun 05, 2001 at 08:05:34AM +0100, Alan Cox wrote:
> > > is curious as to how these folks did this.  They exploited BIND 8.2.3
> > > to get in and logs indicated that someone was using a "back door" in 

> > Bind runs as root.

> > > We are unable to determine just how they got in exactly, but they 
> > > kept trying and created an oops in the affected code which allowed 
> > > the attack to proceed.  

> > Are you sure they didnt in fact simply screw up live patching the kernel to
> > cover their traces

> Could have.  The kernel is unable to dismount the root volume when booted.
> I can go through the drive and remove confidential stuffd and just leave 
> the system intact and post the entire system image to my ftp server. 

	This would be a good thing for those of us involved in investigating
these sorts of things.  :-/

> I have changed all the passwords on the server, so what's there is no 
> big deal.  This server was public FTP and web/email, so nothing really 
> super "confidential" on it.  

> Jeff

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

