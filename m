Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318722AbSHAMGR>; Thu, 1 Aug 2002 08:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318728AbSHAMFa>; Thu, 1 Aug 2002 08:05:30 -0400
Received: from [195.39.17.254] ([195.39.17.254]:11904 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318722AbSHAMFF>;
	Thu, 1 Aug 2002 08:05:05 -0400
Date: Thu, 1 Aug 2002 12:51:46 +0200
From: Pavel Machek <pavel@elf.ucw.cz>
To: Tim Hockin <thockin@sun.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: janitorial PATCH: 2.4:  nvram.c Lindent
Message-ID: <20020801105146.GD159@elf.ucw.cz>
References: <3D47170E.20003@sun.com> <200207302252.g6UMqrj01538@penguin.transmeta.com> <3D4775BB.1090708@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4775BB.1090708@sun.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> 
> >>This patch is pretty simple:  It runs drivers/char/nvram.c through 
> >>Lindent, with a few manual cosmetics on top.  I'm sending this now 
> >>because it makes my follow-up patch to this file easier :)
> 
> >If you're doing these kinds of Lindent changes, you might as well also
> >fix another non-linuxism:
> >
> >	return (x);	->	return x;
> 
> OK - I fixed up the return codes, too.  Both csets are available for 
> pulling:

You could also update CodingStyle when Linus is lazy ;-).


-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
