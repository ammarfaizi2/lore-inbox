Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281436AbRKPOni>; Fri, 16 Nov 2001 09:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281433AbRKPOn3>; Fri, 16 Nov 2001 09:43:29 -0500
Received: from yktgi01e0-s3.watson.ibm.com ([198.81.209.17]:43153 "HELO
	ssm22.watson.ibm.com") by vger.kernel.org with SMTP
	id <S281436AbRKPOnQ>; Fri, 16 Nov 2001 09:43:16 -0500
Date: Fri, 16 Nov 2001 06:05:23 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Anders Peter Fugmann <afu@fugmann.dhs.org>, linux-kernel@vger.kernel.org
Subject: Re: Scheduler
Message-ID: <20011116060523.A2370@watson.ibm.com>
In-Reply-To: <3BF415F2.2010204@fugmann.dhs.org> <20011115134017.B23386@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <20011115134017.B23386@mikef-linux.matchmail.com>; from Mike Fedyk on Thu, Nov 15, 2001 at 01:40:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mike Fedyk <mfedyk@matchmail.com> [20011115 16;40]:"
> On Thu, Nov 15, 2001 at 08:22:26PM +0100, Anders Peter Fugmann wrote:
> > Hi all.
> > 
> > I'm about to start my master thesis, and for this I'm thinking of 
> > implementing a new scheduler for Linux.
> > 
> > The project will be mostly theoretical, and I'm therefore looking for 
> > pointers to papers describing schduling methods for SMP systems.
> > 
> > As a part of the project will be to implement a new scheduler, I also 
> > would like to know if any of you have some good pointers to eksisting 
> > scheduling projects.
> > 
> 
> goto kernelnewbies.org/patches/ and search for "sched".
> 
> It'll list all of them that I know about except for the MQ secheduler.

The MQ you can find at http://lse.sourceforge.net/scheduling

> 
> Mike
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
