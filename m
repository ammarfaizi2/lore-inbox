Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265797AbRFXXe4>; Sun, 24 Jun 2001 19:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265798AbRFXXer>; Sun, 24 Jun 2001 19:34:47 -0400
Received: from [209.250.53.201] ([209.250.53.201]:27400 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S265797AbRFXXec>; Sun, 24 Jun 2001 19:34:32 -0400
Date: Sun, 24 Jun 2001 17:39:28 -0500
From: Steven Walter <srwalter@yahoo.com>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010624173928.A14013@hapablap.dyn.dhs.org>
In-Reply-To: <Pine.LNX.3.96.1010622162213.32091B-100000@artax.karlin.mff.cuni.cz> <0106220929490F.00692@localhost.localdomain> <20010624234101.A1619@werewolf.able.es> <01062412555901.03436@localhost.localdomain> <20010625003002.A1767@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010625003002.A1767@werewolf.able.es>; from jamagallon@able.es on Mon, Jun 25, 2001 at 12:30:02AM +0200
X-Uptime: 5:37pm  up 1 day, 16:19,  1 user,  load average: 1.38, 1.46, 1.57
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2001 at 12:30:02AM +0200, J . A . Magallon wrote:
> Take a programmer comming from other system to linux. If he wants multi-
> threading and protable code, he will choose pthreads. And you say to him:
> do it with 'clone', it is better. Answer: non protable. Again: do it
> with fork(), it is fast in linux. Answer: better for linux, but it is a
> real pain in other systems.
> 
> And worst, you are allowing people to program based on a tool that will give
> VERY diferent performance when ported to other systems. They use fork().
> They port their app to solaris. The performance sucks. It is not Solaris
> fault. It is linux fast fork() that makes people not looking for the
> correct standard tool for what they want todo.

This sounds to my like "Linux is making other OSes look bad.  Cut it
out."
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
