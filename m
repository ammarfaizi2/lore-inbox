Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSLJMIe>; Tue, 10 Dec 2002 07:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbSLJMIe>; Tue, 10 Dec 2002 07:08:34 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:15337 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261318AbSLJMId>;
	Tue, 10 Dec 2002 07:08:33 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: James Simmons <jsimmons@infradead.org>
Date: Tue, 10 Dec 2002 13:15:55 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Linux 2.5.51
Cc: <linux-kernel@vger.kernel.org>, allan.d@bigpond.com
X-mailer: Pegasus Mail v3.50
Message-ID: <9EC19CF6B8E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Dec 02 at 22:49, James Simmons wrote:
> > > quite large.
> >
> > Unfortunately not all went well with this:
> >
> > drivers/video/matrox/matroxfb_base.h:52:25: video/fbcon.h: No such file or directory
> >
> > ... and downwards thereafter.
> 
> The matrox driver hasn't be ported yet. About 1/2 are now ported to the
> final api. Over the following week I will porting a bunch of new drivers.
> This is the final changes in the api so drivers can now be ported!!!! If
> you need help porting them email me and I'm here to help.

Hi James,
  I'm glad to see that fbdev changes finally arrived, so I can look at them
without using your patches ;-) If you have some changes to matroxfb besides
ones which are in the tree, please send me them... because of I really
need matroxfb running on my machine, I'll make it top priority, just below
my "real" work.
                                                    Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        
