Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131294AbQKNVx3>; Tue, 14 Nov 2000 16:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131378AbQKNVxJ>; Tue, 14 Nov 2000 16:53:09 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:32519 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S130704AbQKNVw6>; Tue, 14 Nov 2000 16:52:58 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Tue, 14 Nov 2000 14:22:55 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_EISA note in Documentation/Configure.help
MIME-Version: 1.0
Message-Id: <00111414225502.03227@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
>
>(i) I am a bit unhappy about adding configuration options
>like this. It regularly happens that I want to compile some kernel
>for some machine and have to grep the source and look at the config
>files how to enable something. A machine with RTL-8139? Let me see,

I apologize: I did not specify that the patch for configure.help was for
2.4.0-test series only.   Looking at 2.2.17, there is _no_ CONFIG_EISA.

>However, CONFIG_EISA is almost completely superfluous, is not
>required at compile time, can easily be tested at run time,
>in other words adding such an option is a very stupid thing to do.

Well, it got added sometime, and its there now for 2.4.0-testX.  I am just 
trying to fill in the blanks so that the help buttons have something helpful 
to say. 

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
