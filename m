Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130453AbRABPW2>; Tue, 2 Jan 2001 10:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131148AbRABPWS>; Tue, 2 Jan 2001 10:22:18 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:65474 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130453AbRABPWA>; Tue, 2 Jan 2001 10:22:00 -0500
Date: Tue, 2 Jan 2001 09:51:34 -0500
From: Matthew Galgoci <mgalgoci@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: iopener reboot
Message-ID: <20010102095134.A32445@redhat.com>
Reply-To: mgalgoci@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've gone and tried the ultimate acid test of crappy x86 hardware on the 
vanilla prerelease kernel, and installed it on my iopener. The kernel 
loads, uncompresses, initializes hardware, and then immediately reboots.

It all happens so fast that I do not really get a chance to see the last thing
printed before it fails.

The last kernel that I had running on this was a test12 pre something.

Any ideas?

--Matt Galgoci

-- 
"Hey Y'all, Watch this!" --Mike Wangsmo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
