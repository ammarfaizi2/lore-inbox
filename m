Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWAaU4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWAaU4H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWAaU4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:56:06 -0500
Received: from smtp.uaf.edu ([137.229.34.30]:4868 "EHLO smtp.uaf.edu")
	by vger.kernel.org with ESMTP id S1751393AbWAaU4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:56:06 -0500
From: Joshua Kugler <joshua.kugler@uaf.edu>
Organization: UAF Center for Distance Education - IT
To: Jens Axboe <axboe@suse.de>
Subject: Re: [OT] 8-port AHCI SATA Controller?
Date: Tue, 31 Jan 2006 11:48:52 -0900
User-Agent: KMail/1.7.2
Cc: Sander <sander@humilis.net>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
References: <20060131115343.GA2580@favonius> <20060131185646.GF6178@favonius> <20060131203845.GH4215@suse.de>
In-Reply-To: <20060131203845.GH4215@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601311148.52955.joshua.kugler@uaf.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 January 2006 11:38, Jens Axboe wrote:
> On Tue, Jan 31 2006, Sander wrote:
> > > I got the drivers here:
> > >
> > > http://www.keffective.com/mvsata/FC3/
> > >
> > > The latest was mvSata_Linux_3.6.1.tgz as of 2005-10-13.
> >
> > I very, very much prefer in-tree drivers :-)
>
> Actually there is a sata_mv driver in the kernel, however it's pretty
> experimental right now. I'm sure it could use testers :-)

Interesting.  I understand it going through testing, but why didn't they pull 
in the mvSata driver referenced above?  It was already GPL.  Or did they pull 
in that driver and just want testing?

j----- k-----

-- 
Joshua Kugler                 PGP Key: http://pgp.mit.edu/
CDE System Administrator             ID 0xDB26D7CE
http://distance.uaf.edu/
