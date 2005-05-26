Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVEZKQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVEZKQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 06:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVEZKQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 06:16:34 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:64936 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261299AbVEZKQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 06:16:32 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 May 2005 12:15:01 +0200
To: schilling@fokus.fraunhofer.de, mrmacman_g4@mac.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <4295A1A5.nail2SW21JHSO@burner>
References: <42947A75.nail1XA2FQPXX@burner>
 <B12D948C-4CE9-4139-B0D6-68F8526D0F43@mac.com>
In-Reply-To: <B12D948C-4CE9-4139-B0D6-68F8526D0F43@mac.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> wrote:

> On May 25, 2005, at 09:15:33, Joerg Schilling wrote:
> > If Linux believes that there should be enhanced security similar to  
> > Solaris and
> > if Linux is a true open Source business, then I would expect that  
> > there is
> > cooperation. If I change things in e.g. mkisofs or cdrecord that  
> > could result
> > in problems for my "users", I send a notification mail to the  
> > XCDRoast & k3b
> > authors early enough.
>
> There was a security hole in the CD burner support.  The Linux Kernel  
> developers
> fixed it quickly.  They were not planning to wait 6 months for you to  
> get an
> updated version of cdrecord out the door in any case.  If you want more
> information on the Linux Kernel security policy, please see a recent  
> copy of the
> linux kernel for the file Documentation/SecurityBugs.  To quote the  
> relevant

Looks like you did not read the mail from me you were replying to.

The best way to fix a problem is to fix the problem and not to do something 
else and to change the interface.

The problem was that you could send SCSI commands on R/O fds and fixing the
problem would have been to forbid sending SCSI commands on R/O fds.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
