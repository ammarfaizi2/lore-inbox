Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313325AbSDLDWo>; Thu, 11 Apr 2002 23:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313326AbSDLDWn>; Thu, 11 Apr 2002 23:22:43 -0400
Received: from elin.scali.no ([62.70.89.10]:31501 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S313325AbSDLDWm>;
	Thu, 11 Apr 2002 23:22:42 -0400
Date: Fri, 12 Apr 2002 05:22:39 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
To: Thomas Duffy <tduffy@afara.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IRIX NFS server and Linux NFS client
In-Reply-To: <AFARA-EXXsNQptgFrYI0000121c@afara-ex.afara.com>
Message-ID: <Pine.LNX.4.30.0204120519150.10585-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2002, Thomas Duffy wrote:

> On Thu, 11 Apr 2002 03:23:15 -0700, Steffen Persvold wrote:
>
> > On Thu, 11 Apr 2002, Steffen Persvold wrote:
> >
> >> Hi all,
> >>
> >> Is there any reason why my Linux NFS client (kernel 2.4.18
> >> nfs-utils-0.3.1-13.7.2.1 from RedHat 7.2) is not able to mount a
> >> directory exported from an IRIX server in NFSv3 (not sure which version
> >> of IRIX yet, if this is important I will find out). NFSv2 works fine,
> >> but if I try to force NFSv3 I get "Connection refused".
>
> What version of IRIX are you using?
>
> There was a fix put into IRIX in the 6.5.12/13 timeframe that made it
> more compatible with Linux.  Make sure you are updated to at least that
> release.
>

Hmm It's IRIX 6.4 and unfortunately the server can''t be upgraded. Is
there a ChangeLog somewhere (for IRIX) which describes the changes you
mention a bit more in detail ? I looked at the SGI homepage, but I didn't
seem to find
it.

Thanks,
 --
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency

