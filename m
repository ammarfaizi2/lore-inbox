Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWA0LGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWA0LGi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 06:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWA0LGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 06:06:38 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:40068 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S964982AbWA0LGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 06:06:38 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 27 Jan 2006 12:05:02 +0100
To: schilling@fokus.fraunhofer.de, chaosite@gmail.com
Cc: rlrevell@joe-job.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D9FE5E.nailEM5412F0S@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <787b0d920601251826l6a2491ccy48d22d33d1e2d3e7@mail.gmail.com>
 <43D8D396.nailE2X31OHFU@burner> <43D8FF43.6050907@gmail.com>
In-Reply-To: <43D8FF43.6050907@gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matan Peled <chaosite@gmail.com> wrote:

> Joerg Schilling wrote:
> > Albert Cahalan <acahalan@gmail.com> wrote:
> >> Names can be handled by Windows, FreeBSD, MacOS X,
> >> Linux, OpenBSD, Solaris, HP-UX, AIX, and IRIX.
> >> That's everything that isn't end-of-lifed.
> > Aha, so you like to state that MS-WIN is end-of-lifed?
> > Is this secret new information from Microsoft?
>
> I'm not an expert in SCSI implementation quirks across varying platfroms, but 
> you made a mistake here, Joerg.
>
> Albert put Windows (==MS-WIN) in that list. First one, even.

I encourage you to inform yourself about MS-WIN and to find you that
you are wrong.

Under MS-WIN, you use either ASPI -> no open fd at all
or you use something that is very similar to my /dev/scg* device 
on Solaris which uses/defines abstract SCSI transport devices instead of 
possibly unknown high level devices like a disk driver.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
