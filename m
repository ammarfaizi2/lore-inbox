Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282453AbRLGRnK>; Fri, 7 Dec 2001 12:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282644AbRLGRnA>; Fri, 7 Dec 2001 12:43:00 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:58892 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S282453AbRLGRml>; Fri, 7 Dec 2001 12:42:41 -0500
Message-ID: <3C10FF86.941D79AC@delusion.de>
Date: Fri, 07 Dec 2001 18:42:30 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: release() locking
In-Reply-To: <3C10D83E.81261D74@delusion.de> <3C10FDCF.D8E473A0@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Yes, others have suggested that the whole lot should be reverted,
> for several reasons.  However it looks like that won't happen, so we
> need to debug the present code.  But it works for me.
> 
> I can review the code, see if anything stands out.  But it'll probably
> require someone who can reproduce it to be able to fix it.

That would be good. I can reliably reproduce the problem, so if you
want me to try out some patches, just send them here.

Regards,
Udo.
