Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRCBNAu>; Fri, 2 Mar 2001 08:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRCBNAn>; Fri, 2 Mar 2001 08:00:43 -0500
Received: from [63.95.87.168] ([63.95.87.168]:2575 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S129112AbRCBNAI>;
	Fri, 2 Mar 2001 08:00:08 -0500
Date: Fri, 2 Mar 2001 08:00:07 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is 2.4 Linux networking performance like compared to BSD?
Message-ID: <20010302080007.A23310@xi.linuxpower.cx>
In-Reply-To: <Pine.A41.4.33.0102282123180.68876-100000@aix09.unm.edu>, <3A9E96A6.41D725A3@namesys.com> <97nnil$dn9$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <97nnil$dn9$1@forge.intermeta.de>; from hps@tanstaafl.de on Fri, Mar 02, 2001 at 09:02:13AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2001 at 09:02:13AM +0000, Henning P. Schmiedehausen wrote:
> reiser@namesys.com (Hans Reiser) writes:
> > If I can't get information about BSD v. Linux 2.4 networking code,
> > then reiserfs has to get ported to BSD which will be both nice and a
> > pain to do.
> 
> So we would get dual-licensed ReiserFS (BSD and GPL)? 
> 
> Are you aware of the legal implications, making your currently
> GPL-only code BSD-licensed (status of third party patches for the GPL
> code and so on)?

There would be no reason to BSD licence ReiserFS.. The intent of the BSD
licence is to let anyone who wants to lock it up with more restrictive
licences do so, and if the result is more popular.. take over control of the
software. 

So Hans could easily release a GPLed copy of FreeBSD with reiserfs. This
type of activity is encouraged by the BSD people.
