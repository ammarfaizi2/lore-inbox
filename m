Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319238AbSHUWvl>; Wed, 21 Aug 2002 18:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319239AbSHUWvl>; Wed, 21 Aug 2002 18:51:41 -0400
Received: from tolkor.SGI.COM ([192.48.180.13]:41438 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S319238AbSHUWvh>;
	Wed, 21 Aug 2002 18:51:37 -0400
Date: Wed, 21 Aug 2002 17:55:32 -0500
From: Nathan Straz <nstraz@sgi.com>
To: Joseph <jospehchan@yahoo.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to measure kernel performance?
Message-ID: <20020821225532.GA1411@sgi.com>
Mail-Followup-To: Joseph <jospehchan@yahoo.com.tw>,
	linux-kernel@vger.kernel.org
References: <10d701c244db$c6fb26b0$3716a8c0@taipei.via.com.tw> <E17hdwK-0001ES-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17hdwK-0001ES-00@starship>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 12:26:59AM +0200, Daniel Phillips wrote:
> On Friday 16 August 2002 03:04, Joseph wrote:
> >  I want to know how to measure the current kernel performance.
> >  (Is there any benchmark tool available?)
> >  But I have no idea. Could anybody tell me how to do this?
> >  Any help is appreciated.
> 
> I haven't tried this myself, but it looks interesting:
> 
>   http://oss.sgi.com/projects/pcp/
>   (Performance Co-Pilot)

I started using it again recently.  I really like it.  I believe the
package on oss.sgi.com doesn't include a graphical monitoring package.
I don't think SGI ever released that for Linux, which is too bad because
it's really cool[1].  

Michal Kara worked on creating a graphical monitoring package called
PCPMON[2] but I haven't tried it out yet. 

[1] http://www.sgi.com/software/co-pilot/overview.html
[2] http://k332.feld.cvut.cz/~lemming/projects/pcpmon.html
-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                                  http://ltp.sf.net/
