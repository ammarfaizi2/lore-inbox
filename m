Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129281AbRBLWEO>; Mon, 12 Feb 2001 17:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131450AbRBLWEE>; Mon, 12 Feb 2001 17:04:04 -0500
Received: from mailman.techspan.com ([4.21.76.5]:62468 "EHLO
	mailman.techspan.com") by vger.kernel.org with ESMTP
	id <S130786AbRBLWDx>; Mon, 12 Feb 2001 17:03:53 -0500
Message-ID: <3A885DC7.5060201@techspan.com>
Date: Mon, 12 Feb 2001 17:03:51 -0500
From: Mark Swanson <Mark.Swanson@techspan.com>
Organization: Techspan
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.14-win4lin i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-ac10 loop/encryption lockups.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

With ac5 I could mount loopback filesystems that were aes encrypted. All 
I get with ac10 is a lockup.

Will test patches.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
