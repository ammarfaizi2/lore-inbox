Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289748AbSAOX1r>; Tue, 15 Jan 2002 18:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289759AbSAOX1h>; Tue, 15 Jan 2002 18:27:37 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:47262 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S289748AbSAOX1Z>; Tue, 15 Jan 2002 18:27:25 -0500
Message-ID: <3C44BB1B.E1F3318C@didntduck.org>
Date: Tue, 15 Jan 2002 18:28:27 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Thalinger <e9625286@student.tuwien.ac.at>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: floating point exception
In-Reply-To: <1010925802.674.0.camel@sector17.home.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Thalinger wrote:
> 
> Hi!
> 
> Just downloaded again, after a long time, the setiathome client. I
> wanted to look how smooth my tyan dual works. So i started the client
> and after a few seconds it gets and `floating point exception'. No
> problem till now, cause it seems to be seti bug. Ok.
> 
> Right after that my window manager segfaults. Ok, switch to console,
> restart it and go. No! Can't start any programs anymore, no login. All
> tasks die one after the other, up to the complete lock of the machine.
> Even alt-sysrq doesn't work.
> 
> So, this is kernel 2.4.17 and i'll try other kernels right after this
> email.
> 
> Anyone knows what's going on?

What CPU do you have?  Do you have the FPU emulator compiled in?  Are
there any oops messages?

--
						Brian Gerst
