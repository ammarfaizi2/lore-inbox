Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130172AbRBWSiB>; Fri, 23 Feb 2001 13:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131304AbRBWShv>; Fri, 23 Feb 2001 13:37:51 -0500
Received: from dnscache.uknet.spacesurfer.com ([213.253.36.77]:9479 "HELO
	blackhole.uknet.spacesurfer.com") by vger.kernel.org with SMTP
	id <S130172AbRBWShg>; Fri, 23 Feb 2001 13:37:36 -0500
Message-ID: <3A96AE98.E7754F9C@spacesurfer.com>
Date: Fri, 23 Feb 2001 18:40:24 +0000
From: Patrick Mackinlay <patrick@spacesurfer.com>
Reply-To: patrick@spacesurfer.com
Organization: SpaceSurfer Ltd.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: reiserfs problem
In-Reply-To: <462990000.982953084@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> On Friday, February 23, 2001 05:03:40 PM +0000 Patrick Mackinlay
> <patrick@spacesurfer.com> wrote:
> 
> > When 2.4.1 was released I reported a kernel oops with reiserfs, I got no
> > response.
> 
> Hmmm, don't seem to have any other reiserfs mail from you.  Sorry I missed
> it.
> 
> [ ...]
> >
> > kernel oops report:
> >>> EIP; d2cf9db8 <[reiserfs]create_virtual_node+298/490>   <=====
> 
> We've had a half dozen or so reports so far of this, almost every time it
> has been resolved as a compiler issue, usually an unpatched gcc 2.96.  One
> user was using 2.95.3, but did not report back if switching to 2.95.2 or
> egcs fixed the oops.
> 
> Anyway, which compiler did you use to compile the kernel?
> 
> -chris

I didn't want to join the kernel mailing list (too much traffic) so I
sent it to the email address suggested on the reiserfs home page. I
guess it didn't get through.

It seems I am in fact using a buggy compiler (damn RedHat 7, forgot I
had upgraded on this machine) I will try re-compiling with another
compiler and let you know if I still have problems.

regards,
Patrick

-- 
Patrick Mackinlay                                patrick@spacesurfer.com
ICQ: 59277981                                        tel: +44 7050699851
                                                     fax: +44 7050699852
SpaceSurfer Limited                          http://www.spacesurfer.com/
