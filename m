Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265354AbUHWPqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUHWPqH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUHWPqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:46:02 -0400
Received: from [212.209.10.220] ([212.209.10.220]:39598 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S265808AbUHWPgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:36:40 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Sam Ravnborg'" <sam@ravnborg.org>,
       "Mikael Starvik" <mikael.starvik@axis.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2.4] CRIS architecture update
Date: Mon, 23 Aug 2004 17:36:38 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668640E23@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668013FA8A2@exmail1.se.axis.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I'll send in a patch this week with basically the same
things as in the 2.4 patch.

The new sub-arch will be added once we have the real hardware
available (runs in silicon simulator today). 

/Mikael

-----Original Message-----
From: Sam Ravnborg [mailto:sam@ravnborg.org] 
Sent: Monday, August 23, 2004 5:29 PM
To: Mikael Starvik
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] CRIS architecture update


On Mon, Aug 23, 2004 at 05:01:55PM +0200, Mikael Starvik wrote:
> As requested on this list a while ago I send patches for the
> CRIS architecture here before they are sent to Marcelo/Andrew.
> Most of you doesn't care at all and that's just fine.

Any plans for a 2.6 update soon?
You mentioned a new sub-arch and moving drivers.

	Sam

