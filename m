Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265785AbUAPVEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 16:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUAPVEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 16:04:14 -0500
Received: from cliff.cse.wustl.edu ([128.252.166.5]:27895 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP id S265785AbUAPVEI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 16:04:08 -0500
From: "Cheng Huang" <cheng@cse.wustl.edu>
To: "'Nerijus Baliunas'" <nerijus@users.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Hang with Promise Ultra100 TX2 (kernel 2.4.18)
Date: Fri, 16 Jan 2004 15:04:04 -0600
Message-ID: <006901c3dc74$466be8e0$0400a8c0@ChengDELL>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20040115154755.CE15E5DA0@mx.ktv.lt>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry not to mention. I have already applied the patch before I asked
this question. Any further suggestions? Thanks.

-- Cheng

-----Original Message-----
From: Nerijus Baliunas [mailto:nerijus@users.sourceforge.net] 
Sent: Thursday, January 15, 2004 9:43 AM
To: linux-kernel@vger.kernel.org
Cc: Cheng Huang
Subject: Re: Hang with Promise Ultra100 TX2 (kernel 2.4.18)

On Thu, 15 Jan 2004 13:49:22 +0200 Pasi Kärkkäinen <pasik@iki.fi> wrote:

> On Thu, Jan 15, 2004 at 03:17:12AM -0600, Cheng Huang wrote:
> > I have to use kernel 2.4.18 because I need to install KURT (realtime
> > linux) with it. However, my system hangs on boot with the following
> > message:
> 
> I think there has been a lot of bug fixes in the latest 2.4 kernels
for
> promise cards.
> 
> I'm running promise ultra133-tx2 successfully with 2.4.22 kernel.
> 
> Merge the promise driver from later 2.4.x kernels to 2.4.18 and
recompile? 

When I used 2.4.18 I had Andre's ide.2.4.18-rc1.02152002.patch.bz2
applied.

Regards,
Nerijus

