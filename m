Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130855AbRBAUSi>; Thu, 1 Feb 2001 15:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131334AbRBAUS3>; Thu, 1 Feb 2001 15:18:29 -0500
Received: from mail.mediaways.net ([193.189.224.113]:41591 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S130855AbRBAUSY>; Thu, 1 Feb 2001 15:18:24 -0500
Date: Thu, 1 Feb 2001 21:18:20 +0100
From: Walter Hofmann <walter.hofmann@physik.stud.uni-erlangen.de>
To: Gregory Maxwell <greg@linuxpower.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NT soon to surpass Linux in specweb99 performance?
Message-ID: <20010201211820.A12055@frodo.uni-erlangen.de>
In-Reply-To: <20010201143825.A21237@xi.linuxpower.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010201143825.A21237@xi.linuxpower.cx>; from greg@linuxpower.cx on Thu, Feb 01, 2001 at 02:38:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Feb 2001, Gregory Maxwell wrote:

> Looks like TUX caught MS's attention:
> http://www.spec.org/osg/web99/results/res2000q4/web99-20001211-00082.html
> 
> Anyone know if their method of achieveing this is as flexible as TUX, or is
> their "SWC 3.0" simply mean 'spec web cheat' and involve implimenting the
> specweb dyanmic stuff in x86 assembly in their microkernel? :)

SWC = Scaleable Web Cache

http://www.microsoft.com/technet/iis/swc2.asp has more information about
SWC 2.0. Microsoft published SpecWeb96 results for IIS+SWC 2.0, but not
for SpecWeb99. I would guess that SWC 2.0 didn't help performance for
dynamic content.

Looks like they fixed this with SWC 3.0.

Walter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
