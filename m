Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317278AbSHBVbx>; Fri, 2 Aug 2002 17:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317286AbSHBVbw>; Fri, 2 Aug 2002 17:31:52 -0400
Received: from smtp1.auracom.net ([165.154.140.23]:38596 "EHLO
	smtp1.auracom.net") by vger.kernel.org with ESMTP
	id <S317278AbSHBVbw>; Fri, 2 Aug 2002 17:31:52 -0400
To: root@chaos.analogic.com
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Kernel compiled from source won't read /parts/ of a CD?
References: <Pine.LNX.3.95.1020801154900.873A-100000@chaos.analogic.com>
From: Gary Lawrence Murphy <garym@canada.com>
X-Home-Page: http://www.teledyn.com
Organization: TCI Business Innovation through Open Source Computing
Date: 02 Aug 2002 16:36:42 -0400
Message-ID: <m265yt2e1x.fsf@maya.dyndns.org>
Reply-To: Gary Lawrence Murphy <garym@canada.com>
X-Url: http://www.teledyn.com/
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "R" == Richard B Johnson <root@chaos.analogic.com> writes:

    R> I had some problem like this. I don't know what caused it
    R> because it was 'fixed' by a re-boot. I think it was that the
    R> kernel 'thought' the block-size was wrong for the CD.

Glory be, that did fix it -- overnight since I posted this we had a
power out and this morning the problem is gone.  Who would have thought
of rebooting a /linux/ machine??!!! :)

Thanks for the tip; if it does ever happen again, I'll also try the
loopback thing to see if that gives any clues.

-- 
Gary Lawrence Murphy <garym@teledyn.com> TeleDynamics Communications Inc
Business Innovations Through Open Source Systems: http://www.teledyn.com
"Computers are useless.  They can only give you answers."(Pablo Picasso)

