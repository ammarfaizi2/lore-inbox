Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVEYXMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVEYXMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 19:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVEYXMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 19:12:33 -0400
Received: from smtpout.mac.com ([17.250.248.72]:19691 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261590AbVEYXM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 19:12:26 -0400
In-Reply-To: <42947A75.nail1XA2FQPXX@burner>
References: <42947A75.nail1XA2FQPXX@burner>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B12D948C-4CE9-4139-B0D6-68F8526D0F43@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Date: Wed, 25 May 2005 19:12:18 -0400
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 25, 2005, at 09:15:33, Joerg Schilling wrote:
> If Linux believes that there should be enhanced security similar to  
> Solaris and
> if Linux is a true open Source business, then I would expect that  
> there is
> cooperation. If I change things in e.g. mkisofs or cdrecord that  
> could result
> in problems for my "users", I send a notification mail to the  
> XCDRoast & k3b
> authors early enough.

There was a security hole in the CD burner support.  The Linux Kernel  
developers
fixed it quickly.  They were not planning to wait 6 months for you to  
get an
updated version of cdrecord out the door in any case.  If you want more
information on the Linux Kernel security policy, please see a recent  
copy of the
linux kernel for the file Documentation/SecurityBugs.  To quote the  
relevant
part:  "It is reasonable to delay disclosure ... or for vendor  
coordination.
However we expect these delays to be short, measurable in days, not  
weeks or
months."  Part of this policy includes "we'd like to know when a  
security bug is
found so that it can be fixed and disclosed as quickly as possible."   
This seems
to imply that the security team is not likely to wait 6 months to fix  
a critical
hardware-damaging vulnerability.

> If the cause for the change really was the "security problem"  
> caused by the
> fact that Linux did allow to send SCSI commands on R/O file  
> descriptors it
> would have been sufficient to require R/W permissions on the fd.  
> After this
> putative small change, the supposed problem would have been fixed  
> and cdrtools
> as well as other users of the interface did work as before.

I will not debate this issue with you.  Please see the copious  
quantities of
emails when this issue was brought up a while ago.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



