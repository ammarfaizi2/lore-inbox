Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135723AbRD3Sqb>; Mon, 30 Apr 2001 14:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135681AbRD3SqV>; Mon, 30 Apr 2001 14:46:21 -0400
Received: from [63.109.146.2] ([63.109.146.2]:3068 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S135532AbRD3SqJ>;
	Mon, 30 Apr 2001 14:46:09 -0400
Message-ID: <B65FF72654C9F944A02CF9CC22034CE22E1B9F@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Kenneth Johansson'" <ken@canit.se>,
        Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4 and 2GB swap partition limit
Date: Mon, 30 Apr 2001 11:45:59 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kenneth Johansson wrote:
> Jonathan Lundell wrote:
> >
> > (Does Linux swap out text, by the way, he asks ignorantly?)
> 
> .text is just droped and read back from the actuall file it's 
> not put into the swap

Is this always true, even for init?  Can init be swapped out?  

In general, is there a safe way to replace executable files for
programs that might be running while their on-disk images are
replaced?

Thanks for any hints...

Torrey Hoffman
torrey.hoffman@myrio.com
