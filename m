Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbTEMPFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTEMPFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:05:37 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:22766 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S261392AbTEMPFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:05:36 -0400
Subject: Re: logs full of chatty IDE cdrom
From: Martin Schlemmer <azarah@gentoo.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1052599284.19351.2.camel@dhcp22.swansea.linux.org.uk>
References: <20030510201744.GD662@gallifrey>
	 <1052599284.19351.2.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1052736196.5717.104.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 12 May 2003 12:43:17 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-10 at 22:41, Alan Cox wrote:
> On Sad, 2003-05-10 at 21:17, Dr. David Alan Gilbert wrote:
> > Hi,
> >   I'm not sure but this seems to be a lot worse in 2.5.x for some
> > reason; my logs are full of I/O errors, not ready's and other errors from
> > my CDROM drive that is playing audio CDs; I suspect at least some of it
> > is due to kscd trying to figure out if there is a CD in an empty drive.
> 
> That shouldnt be generating messages. Its more important to know why or
> to see wtf its doing that generates them
> 

I have a Toshiba DVD drive, that while quiet in 2.4, generates 3-4
messages just during kernel start and initial module loading ..
I can forward it if need be.


Regards,

-- 
Martin Schlemmer


