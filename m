Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129378AbRBOSoY>; Thu, 15 Feb 2001 13:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129776AbRBOSoO>; Thu, 15 Feb 2001 13:44:14 -0500
Received: from colorfullife.com ([216.156.138.34]:3853 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129378AbRBOSoE>;
	Thu, 15 Feb 2001 13:44:04 -0500
Message-ID: <3A8C2389.3957EA4B@colorfullife.com>
Date: Thu, 15 Feb 2001 19:44:25 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Nathan Walp <faceprint@faceprint.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-ac14 tulip woes
In-Reply-To: <3A8C1D50.AB6F2E5A@faceprint.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Walp wrote:
> 
> The fix in ac14 for the ac13 patch that killed the tulip driver doesn't
> quite work either:
>

I need more details:
does it immediately time out (after a few seconds), or a after a few
minutes.

Which network speed do you use? 100MBit half duplex?

Could you please run the tulip-diag program I send you yesterday?
#tulip-diag -mm -aa -f

both before and after the hang.

Thanks,
	Manfred
