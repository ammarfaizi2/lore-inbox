Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265848AbUBCIry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 03:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265851AbUBCIry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 03:47:54 -0500
Received: from edu.joroinen.fi ([194.89.68.130]:18670 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S265848AbUBCIrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 03:47:53 -0500
Date: Tue, 3 Feb 2004 10:47:51 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Ryan Verner <xfesty@computeraddictions.com.au>
Cc: LinuxSA ML <linuxsa@linuxsa.org.au>, linux-kernel@vger.kernel.org
Subject: Re: Promise PDC20269 (Ultra133 TX2) + Software RAID
Message-ID: <20040203084751.GJ1254@edu.joroinen.fi>
References: <6FF5C83C-55FA-11D8-AC00-000A95CEEE4E@computeraddictions.com.au> <E9A39380-560F-11D8-8E3C-000A95CEEE4E@computeraddictions.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E9A39380-560F-11D8-8E3C-000A95CEEE4E@computeraddictions.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 04:42:15PM +1030, Ryan Verner wrote:
> On 03/02/2004, at 2:08 PM, Ryan Verner wrote:
> >And the machine is randomly locking up, and of course, on reboot, the 
> >raid array is rebuilt.  Ouch.  Any clues as to why?  I'm sure the hard 
> >drive hasn't failed as it's brand new; I suspect a chipset 
> >compatibility problem or something.
> 
> Definitely seems to be this.  Swapped the drives back over to the 
> onboard-IDE chipset, which is much slower (raid rebuilds at only 
> 7MB/sec instead of 25), but certainly none of these problems.
> 
> Known issue?
> 

I'm running Ultra-133 TX2 with software RAID successfully without any
problems. This is on (mainly) Intel P3 platforms.

-- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
