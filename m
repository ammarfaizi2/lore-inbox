Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289277AbSANXUO>; Mon, 14 Jan 2002 18:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289282AbSANXT7>; Mon, 14 Jan 2002 18:19:59 -0500
Received: from pcow029o.blueyonder.co.uk ([195.188.53.123]:62219 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S289292AbSANXTK>;
	Mon, 14 Jan 2002 18:19:10 -0500
Date: Mon, 14 Jan 2002 23:22:47 +0000
From: Ian Molton <spyro@armlinux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
Message-Id: <20020114232247.195bf441.spyro@armlinux.org>
In-Reply-To: <Pine.LNX.4.40.0201141409580.22904-100000@dlang.diginsite.com>
In-Reply-To: <20020114205124.2f05fc56.spyro@armlinux.org>
	<Pine.LNX.4.40.0201141409580.22904-100000@dlang.diginsite.com>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a sunny Mon, 14 Jan 2002 14:11:48 -0800 (PST) David Lang gathered a
sheaf of electrons and etched in their motions the following immortal
words:

> the impact is in all calls to the module, if they are far calls instead
> of near calls each and every call is (a hair) slower.
> 
> so the code can be the same and still be slower to get to.
> 
> you can argue that it's not enough slower to matter, but even Alan admits
> there is some impact.

Ok, #1 please dont send me courtesy copies without indicating so.

#2 Not all architectures have a problem with 'far' or 'near' calls, and
frankly, I'm glad the kernels design isnt being crippled just to serve the
fundamentally CRAP x86 architecture, for once.
