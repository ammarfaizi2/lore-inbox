Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVEVPy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVEVPy7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 11:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVEVPy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 11:54:59 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:60572 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261827AbVEVPyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 11:54:45 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andrew Haninger <ahaning@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Joerg Schilling flames Linux on his Blog
Date: Sun, 22 May 2005 16:54:11 +0100
User-Agent: KMail/1.8
References: <200505201345.15584.pmcfarland@downeast.net> <105c793f050521182269294d64@mail.gmail.com>
In-Reply-To: <105c793f050521182269294d64@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505221654.11551.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 May 2005 02:22, Andrew Haninger wrote:
> > ... flames the LKML about how Linux breaks cdrecord
> > (instead of just admitting cdrecord is broken)
>
> I've always used cdr-tools on Linux and Windows since it is the
> only/best tool for mastering CDs. It takes the installation of Joerg's
> library, but after that, it's worked wonderfully. This is even the
> tool that is suggested by the HOWTOs that newbies are told to read. It
> has always appeared to me that it was the only/best tool.
>
> If it's broken, then surely there's an unbroken drop-in replacement
> program that should be used. And surely it works much better than
> cdr-tools and is easier to use. However, after a few seconds of Google
> searches, I was unable to find it.
>
> So what is the new tool that is suggested to be used? I'd rather not
> be using broken software. Thanks.
>

cdrdao
http://cdrdao.sourceforge.net/

Does DAO. Can burn subchannel data. Can burn an audio CD.

dvd+-rw-tools
http://fy.chalmers.se/~appro/linux/DVD+RW/

Burns DVD+/-R, though it does use mkisofs (iirc) which is part of cdrtools. 
Seems to burn DVD+R which I have mixed success with the Mandrake fork of 
cdrtools (no fault of Joerg, necessarily).

Therefore I'd recommend you install an unpatched, Joerg original version of 
cdrtools, burn DAOs and audio CDs with cdrdao, and use dvd+-rw-tools 
exclusively for burning DVDs. This combination has served me well, and since 
mastering it I've had no coaster discs.

Up to date GUI tools like k3b (http://k3b.sourceforge.net/) will make all 
these recommendations and set everything up for you. I don't use it myself, 
but I when I've seen it working, it looked good.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
