Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283163AbRK2KsC>; Thu, 29 Nov 2001 05:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283160AbRK2Krw>; Thu, 29 Nov 2001 05:47:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38662 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283158AbRK2Krc>; Thu, 29 Nov 2001 05:47:32 -0500
Subject: Re: 3 Questions
To: linux@sneulv.dk (Allan Sandfeld)
Date: Thu, 29 Nov 2001 10:56:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E169N2Y-0000zS-00@Princess> from "Allan Sandfeld" at Nov 29, 2001 09:59:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169OrV-00086I-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unless they release it GPL, then it might be included in the kernel right? 
> And "the nitty gritty details of making sure its driver software works
> properly across such a range of rapidly changing development
> environments" taken care of by the users of the driver.  They can even track 
> it by CVS, by requesting all patches against the driver to be submitted to 
> them.

Seperate "works" from "supported by". Putting a driver in the kernel makes a
lot of sense, but you'd still probably have an officially supported version.

> They asked for official recommendations, shouldnt the primary recommandation 
> not be to open source it, even if some vendors wont?

They have to open source it anyway, since it is based on the sbus aurora
driver as they said, so its already GPL code.

There is a difference between releasing GPL code and supporting it. Standard
Red Hat support contracts for example stop at the point you go compiling
your own kernel.



