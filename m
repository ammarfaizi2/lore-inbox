Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264055AbRFER25>; Tue, 5 Jun 2001 13:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264056AbRFER2r>; Tue, 5 Jun 2001 13:28:47 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:35845 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S264055AbRFER2f>; Tue, 5 Jun 2001 13:28:35 -0400
Date: Tue, 5 Jun 2001 11:30:51 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: TRG vger.timpanogas.org hacked
Message-ID: <20010605113051.A6209@vger.timpanogas.org>
In-Reply-To: <20010604183642.A855@vger.timpanogas.org> <E157AuE-0006Wc-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E157AuE-0006Wc-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jun 05, 2001 at 08:05:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2001 at 08:05:34AM +0100, Alan Cox wrote:
> > is curious as to how these folks did this.  They exploited BIND 8.2.3
> > to get in and logs indicated that someone was using a "back door" in 
> 
> Bind runs as root.
> 
> > We are unable to determine just how they got in exactly, but they 
> > kept trying and created an oops in the affected code which allowed 
> > the attack to proceed.  
> 
> Are you sure they didnt in fact simply screw up live patching the kernel to
> cover their traces

Could have.  The kernel is unable to dismount the root volume when booted.
I can go through the drive and remove confidential stuffd and just leave 
the system intact and post the entire system image to my ftp server. 

I have changed all the passwords on the server, so what's there is no 
big deal.  This server was public FTP and web/email, so nothing really 
super "confidential" on it.  

Jeff

