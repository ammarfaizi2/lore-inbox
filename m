Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTHTHv5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 03:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbTHTHv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 03:51:57 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:40140 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261754AbTHTHv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 03:51:56 -0400
Date: Wed, 20 Aug 2003 17:52:59 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 0/16] C99: 2.6.0-t3-bk7
Message-ID: <20030820075259.GC459@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok. To follow are 16 patches, broken down by directory that fix up
struct definitions to follow the C99 style. I believe I got all of
them. 

The emails will just contain the patch in the body with nothing else.
I don't think I need to say the same thing over and over at the
beginning of each patch. :)

Also, the patches are against 2.6.0-test3-bk7. They will not apply
cleanly to any earlier version so don't bother unless you plan to
edit. You'll also miss out on some of the C99 cleanups that happened
in bk1-7 that are no longer in my patches.

Finally, I hope the subject meets approval by one and all. ;)

Here we go...

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
