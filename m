Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262292AbRERLJ0>; Fri, 18 May 2001 07:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262293AbRERLJP>; Fri, 18 May 2001 07:09:15 -0400
Received: from jalon.able.es ([212.97.163.2]:46744 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262292AbRERLJI>;
	Fri, 18 May 2001 07:09:08 -0400
Date: Fri, 18 May 2001 13:08:59 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new version of singlecopy pipe
Message-ID: <20010518130859.A1049@werewolf.able.es>
In-Reply-To: <3AFC36BA.B71FC470@colorfullife.com> <20010512020742.A1054@werewolf.able.es> <15100.33537.982370.753962@pizda.ninka.net> <20010512095057.A2539@werewolf.able.es> <15100.62190.251880.613889@pizda.ninka.net> <3B043BBF.6F8E7B7C@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3B043BBF.6F8E7B7C@colorfullife.com>; from manfred@colorfullife.com on Thu, May 17, 2001 at 22:59:43 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.17 Manfred Spraul wrote:
> "David S. Miller" wrote:
> > 
> > J . A . Magallon writes:
> >  > > What platform?
> > 
> >  > Any more info ?
> > 
> > No, I thought it might be some cache flushing issue
> > on a non-x86 machine.
> > 
> I found the problem: 
> I sent out the old patch :-(
> 
> Attached is the correct version of patch-copy_user_user.
> 

Yes, this time it worked fine (against ac11)...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.4-ac11 #2 SMP Fri May 18 12:27:06 CEST 2001 i686

