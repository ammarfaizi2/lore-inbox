Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132817AbRDPAlT>; Sun, 15 Apr 2001 20:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132818AbRDPAlJ>; Sun, 15 Apr 2001 20:41:09 -0400
Received: from [24.70.141.118] ([24.70.141.118]:27886 "EHLO asdf.capslock.lan")
	by vger.kernel.org with ESMTP id <S132817AbRDPAlA>;
	Sun, 15 Apr 2001 20:41:00 -0400
Date: Sun, 15 Apr 2001 20:40:55 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: David Findlay <david_j_findlay@yahoo.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IP Acounting Idea for 2.5
In-Reply-To: <01041707532801.00352@workshop>
Message-ID: <Pine.LNX.4.33.0104152039130.1616-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, David Findlay wrote:

>I am using the kernel IP Accounting in Linux to record the amount of data
>transfered via my Linux internet gateway from individual IP addresses. This
>currently requires me to set up an accounting rule for each IP address that I
>want to record accounting info for. If I had 200 machines to individually log
>this would require me to set 200 rules.
>
>In the 2.5 series of kernels, working towards 2.6, could you please make the
>IP Accounting so that I can set a single rule that will make it watch all IP
>traffic going from the local network, through the masquerading service to the
>internet, and log local IP Addresses using it? This would allow me to set 1
>rule, but have the information I want on a per IP address system.
>
>One other person I have talked to would like to see this too, and he
>basically says we need a software version of the Cisco IP Accounting
>server/router.
>
>Could you please add this to the next kernel? Please CC me your responses as
>I am not a member of the kernel mailing list. Thanks,

Perhaps I misunderstand what it is exactly you are trying to do,
but I would think that this could be done entirely in userland by
software that just adds rules for you instead of you having to do
it manually.

Just a thought.

----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
There are two major products that come out of Berkeley: LSD and BSD.
We don't believe this to be a coincidence.     -- Jeremy S. Anderson

