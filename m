Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270855AbRHXDvt>; Thu, 23 Aug 2001 23:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270857AbRHXDvk>; Thu, 23 Aug 2001 23:51:40 -0400
Received: from [216.151.155.121] ([216.151.155.121]:44296 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S270855AbRHXDvc>; Thu, 23 Aug 2001 23:51:32 -0400
To: Fred <fred@arkansaswebs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File System Limitations
In-Reply-To: <E15a4Gz-0004uz-00@the-village.bc.nu>
	<01082322391300.12871@bits.linuxball>
From: Doug McNaught <doug@wireboard.com>
Date: 23 Aug 2001 23:51:42 -0400
In-Reply-To: Fred's message of "Thu, 23 Aug 2001 22:39:13 -0500"
Message-ID: <m34rqydsj5.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fred <fred@arkansaswebs.com> writes:

> /a5 directory above is /dev/hda5 a vfat partition (is this the problem?)

Almost certainly.

Try it on ext2 (if you have the space) and it should work.

-Doug
-- 
Free Dmitry Sklyarov! 
http://www.freesklyarov.org/ 

We will return to our regularly scheduled signature shortly.
