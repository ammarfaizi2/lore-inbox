Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270813AbUJUTrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270813AbUJUTrB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 15:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270898AbUJUThd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 15:37:33 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:63469 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S270865AbUJUTaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 15:30:06 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 21 Oct 2004 12:30:01 -0700
MIME-Version: 1.0
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <4177ABC9.24323.20E9CA71@localhost>
In-reply-to: <Pine.LNX.4.60.0410201521310.17443@dlang.diginsite.com>
References: <4176E08B.2050706@techsource.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <david.lang@digitalinsight.com> wrote:

> On Wed, 20 Oct 2004, Timothy Miller wrote:
> 
> > Sure, SOME companies release specs so that we can develop 
> > open source drivers, but those cards tend to be prohibitively expensive, 
> > slower than their cheaper counterparts from ATI or nVidia...
> 
> Tim, I think this is the key problem. with the current ATI/nVidia
> cards beign in the $50 range (with other cards on the market for
> as low as $30) are you really going to be able to come up with a
> card that's price competitive? (completely ignoring the
> performance question) 
> 
> as for your other question of if an open approach could be viable
> (after all nobody does it today so doesn't that proove it isn't) 
> 
> this is where there is a significant disagreement. the Linux folks
> think that such openess would be very viable and the companies are
> just pursuing a legacy approach, but the companies are scared to
> open things up becouse they don't believe that they would remain
> viable. 
> 
> since nobody has done this yet (for video cards anyeay) there is
> no proof one way or the other. 

Wrong. Companies *have* tried to go down the Open Source route and it did 
not work out for them. ATI in particular. At one point ATI released all 
the register level information and in fact released sample 3D driver 
source code to the community for the early Radeon chipsets. Unfortunately 
the Linux and Open Source community never stepped up to the plate to 
support ATI in this effort. There are solid business reasons that ATI has 
explained to me for why ATI decided to give up on the Open Source 
approach and go back to proprietary 3D drivers for Linux. 

For 2D they continue to maintain XFree86/X.org drivers with full source 
code for the community, just not 3D.

If someone wishes to go down this route, more power to them. But I don't 
think it is a viable way to make money for a business. The biggest 
problem is that even if every active Linux or Open Source kernel 
developer decided to buy one of these cards, that is a pretty small 
market. The unfortunate fact I have come to realise is that there is a 
very large contingent of Linux end users out there who just want free 
stuff. Free as in free beer. They could care less whether the source code 
is available as long as they don't pay for it. Those same users are also 
more than happy to install ATI or NVIDIA proprietary kernel modules and 
taint their kernel so they can get 3D support when running Linux and 
still run their favorite games at full speed under Windows. Those same 
users probably won't pay a premium to get a 3D card that is slower than 
an ATI or NVIDIA just because it has source code for the drivers.

Sad but true IMHO.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


