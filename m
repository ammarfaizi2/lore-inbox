Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130024AbRAJUTz>; Wed, 10 Jan 2001 15:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbRAJUTp>; Wed, 10 Jan 2001 15:19:45 -0500
Received: from [64.64.109.142] ([64.64.109.142]:772 "EHLO quark.didntduck.org")
	by vger.kernel.org with ESMTP id <S129431AbRAJUTc>;
	Wed, 10 Jan 2001 15:19:32 -0500
Message-ID: <3A5CC3A1.3D8F6BF3@didntduck.org>
Date: Wed, 10 Jan 2001 15:18:41 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: mo6 <sjoos@pandora.be>
CC: Robert Kaiser <rob@sysgo.de>, linux-kernel@vger.kernel.org
Subject: Re: Anybody got 2.4.0 running on a 386 ?
In-Reply-To: <01010922090000.02630@rob> <3A5B7F76.ABDFED7A@didntduck.org> <01010922264400.02737@rob> <20010110205127.B982@pandora.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mo6 wrote:
> I dug up an old amd 386 and started compiling kernels for it with gcc 2.95.2:
> 
> 2.4.0 : doesn't boot, same symptoms as you, Robert, so you're not imagining
>         things :-)
> 2.2.19pre6 : compiles, boots and runs poifectly
> 2.3.51 : doesn't compile
> 2.3.99-pre1 : hrm, *cough*
> 2.3.99-pre2 : *tsjoum*
> 2.3.39: compiles and boots okay
> 
> here is where I got bored :-)
> 
> okay, anyone, which 2.3.x kernels should compile okay ?

move up to 2.4.0-testX kernels

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
