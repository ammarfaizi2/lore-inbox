Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291072AbSAaNqO>; Thu, 31 Jan 2002 08:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291073AbSAaNqC>; Thu, 31 Jan 2002 08:46:02 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:60431 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S291072AbSAaNp4>; Thu, 31 Jan 2002 08:45:56 -0500
Date: Thu, 31 Jan 2002 13:45:31 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        David Weinehall <tao@acc.umu.se>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020131134531.A29479@flint.arm.linux.org.uk>
In-Reply-To: <3C593EEC.3000907@evision-ventures.com> <Pine.LNX.4.33.0201311604050.10258-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201311604050.10258-100000@localhost.localdomain>; from mingo@elte.hu on Thu, Jan 31, 2002 at 04:07:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 04:07:52PM +0100, Ingo Molnar wrote:
> it's not mandatory for the developer to push every interface change into
> every driver or every architecture. Sure, if some code has not been kept
> in sync for a long time then it should be zapped,

add "by the maintainer, if they are still around" here please.

> but the pure fact that
> something is less often used should not make it a candidate for zapping.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

