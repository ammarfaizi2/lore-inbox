Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133100AbRDLLCf>; Thu, 12 Apr 2001 07:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133099AbRDLLC0>; Thu, 12 Apr 2001 07:02:26 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:3589 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S133098AbRDLLCL>;
	Thu, 12 Apr 2001 07:02:11 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Chris Meadors <clubneon@hereintown.net>
Date: Thu, 12 Apr 2001 13:01:13 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] matroxfb and mga XF4 driver coexistence...
CC: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fbdev@vuser.vu.union.edu
X-mailer: Pegasus Mail v3.40
Message-ID: <4BEDDEE649D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Apr 01 at 14:55, Chris Meadors wrote:
> 
> I would like to see this fixed as much as anyone (even complained to the
> XFree people from SuSE last ALS).  But I don't think the fix should be in
> the kernel.  XF4 needs to be fixed.  The problem doesn't just effect the
> maxtroxfb, but also the vgacon video mode selection.

But only users using matroxfb complains to me and/or to linux-kernel ;-)
You know, it worked last week, but it does not work anymore today. And
only thing I changed was kernel. So it must be in kernel...
 
> If I put anything other than "normal" or "extended" in the "vga=" line of
> my lilo.conf the machine starts okay, but upon exiting X bad stuff

It is first time I see that other drivers than mga one has troubles.
 
> I don't use the matroxfb driver so this patch wouldn't help me, and is
> also why I say XFree 4.0 needs to be fixed.

Buy matrox and use matroxfb. It will fix problem for you, then...
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
