Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVCYCY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVCYCY0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 21:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVCYCY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 21:24:26 -0500
Received: from ns1.s2io.com ([142.46.200.198]:60041 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S261276AbVCYCYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 21:24:20 -0500
From: "Ravinandan Arakali" <ravinandan.arakali@neterion.com>
To: "'Adrian Bunk'" <bunk@stusta.de>
Cc: <linux-kernel@vger.kernel.org>,
       "'Leonid. Grossman \(E-mail\)'" <leonid.grossman@neterion.com>
Subject: RE: Problem applying latest 2.6 kernel prepatch(2.6.12-rc1)
Date: Thu, 24 Mar 2005 18:16:37 -0800
Message-ID: <004201c530e0$acf3bef0$3a10100a@pc.s2io.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20050325010828.GQ3966@stusta.de>
Importance: Normal
X-Spam-Score: -102.5
X-Spam-Outlook-Score: ()
X-Spam-Features: EMAIL_ATTRIBUTION,IN_REP_TO,ORIGINAL_MESSAGE,QUOTED_EMAIL_TEXT,REPLY_WITH_QUOTES,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Adrian and Chris. That seems to work.

Ravi

-----Original Message-----
From: Adrian Bunk [mailto:bunk@stusta.de]
Sent: Thursday, March 24, 2005 5:08 PM
To: Ravinandan Arakali
Cc: linux-kernel@vger.kernel.org; Leonid. Grossman (E-mail)
Subject: Re: Problem applying latest 2.6 kernel prepatch(2.6.12-rc1)


On Thu, Mar 24, 2005 at 04:45:58PM -0800, Ravinandan Arakali wrote:
> Hi,
> I am trying to submit patches to our driver in the kernel. Since I need a
> copy of latest kernel
> for this, I installed the latest stable version(2.6.5.11). When I apply
the
> latest prepatch (2.6.12-rc1)
> on top of this, I have the following problems:
>...
> Has anybody else seen this problem or am I missing something ?

The 2.6.12-rc1 patch is against 2.6.11, not against 2.6.11.5 .

> Thanks,
> Ravi

cu
Adrian

--

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


