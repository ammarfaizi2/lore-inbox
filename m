Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282108AbRKWKWU>; Fri, 23 Nov 2001 05:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282112AbRKWKWK>; Fri, 23 Nov 2001 05:22:10 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:20000 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S282108AbRKWKV7>; Fri, 23 Nov 2001 05:21:59 -0500
Date: Fri, 23 Nov 2001 05:27:08 -0500 (EST)
From: rpjday <rpjday@mindspring.com>
X-X-Sender: <rpjday@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Re: is 2.4.15 really available at www.kernel.org?
In-Reply-To: <7xpu69sttm.fsf@colargol.tihlde.org>
Message-ID: <Pine.LNX.4.33.0111230523340.8063-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Nov 2001, Christian Haugan Toldnes wrote:

> rpjday <rpjday@mindspring.com> writes:
> 
>  
> > i swear, i am not making this up.  i just tried again, through mozilla,
> > to download the file 
> > www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.15.tar.bz2, and it 
> > completed after downloading *exactly* 155312 bytes, just as before.
> > 
> > getting it via ftp works fine -- it's http that's giving me this
> > weird problem.   is it just me?
> > 
> > rday
> 
> I experienced no problems at all:
> (first one with ftp, second with mozilla)
> 
> 23747061 Nov 23 07:18 linux-2.4.15.tar.bz2
> 23747061 Nov 23 10:45 linux-2.4.15.tar.bz2-2
> 
then i'm just plain baffled.  using mozilla, i've tried downloading both 
2.4.15 and 2.5.0, from the main www.kernel.org page, and from the kernel
subpage.  in *every* case, the download window starts off fine with
"0K of 28716K", so it knows the right size at the beginning.

the download progresses until it reads 115K of ...K, there is a several
second pause, a brief flurry of activity, and the download terminates.
in *every* case, the final downloaded file is 155312 bytes long.

as i said, i can ftp just fine, but it sure is puzzling me why mozilla
is doing this.

ok, i'll shut up now.

rday

