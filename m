Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbUKHTe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbUKHTe2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 14:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbUKHTdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 14:33:25 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:60603 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261212AbUKHTau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 14:30:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=hB0tgFd8OHpvqUbfI5HgGDmds257WpYD37bbosfQecqzftiDu7CR1hudgNiM+FPoRfSCev9P6ZWUrPjQHvRufVGUvrzgWxIFlST0tgF+EzdXZJPf1gwuFqP6h/FaizZ5vGIQEIpGpueQiHqbggobHZABiv9+eJdL6bI0saICiqA=
Message-ID: <84144f0204110811307ef1be50@mail.gmail.com>
Date: Mon, 8 Nov 2004 21:30:43 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1
Cc: Christian Kujau <evil@g-house.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, alsa-devel@lists.sourceforge.net,
       linux-sound@vger.kernel.org, penberg@cs.helsinki.fi
In-Reply-To: <84144f02041108111816dc0b3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <418D7959.4020206@g-house.de> <418E4705.5020001@g-house.de>
	 <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org>
	 <20041107182155.M43317@g-house.de> <418EB3AA.8050203@g-house.de>
	 <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org>
	 <418F6E33.8080808@g-house.de>
	 <84144f0204110810444400761f@mail.gmail.com>
	 <20041108190040.GC27386@kroah.com>
	 <84144f02041108111816dc0b3a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004 11:00:40 -0800, Greg KH <greg@kroah.com> wrote:
> > But 2.6.10-rc1-bk15 does have the problem?
> >
> > Trying to figure out where the issue is...

On Mon, 8 Nov 2004 21:18:09 +0200, Pekka Enberg <penberg@gmail.com> wrote: 
> No, -bk14 is just the kernel I am running right now (I haven't tried
> -bk15) and I haven't had the problem.

Sorry for not being clear, any kernel after 2.6.10-rc1 oopses
according to Christian which is why I haven't bothered to test
anything else except -bk14.

                           Pekka
