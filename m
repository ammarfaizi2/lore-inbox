Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273755AbRIXDUg>; Sun, 23 Sep 2001 23:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273757AbRIXDU0>; Sun, 23 Sep 2001 23:20:26 -0400
Received: from cs6625186-50.austin.rr.com ([66.25.186.50]:11904 "EHLO
	hatchling.taral.net") by vger.kernel.org with ESMTP
	id <S273755AbRIXDUK>; Sun, 23 Sep 2001 23:20:10 -0400
Date: Sun, 23 Sep 2001 22:20:36 -0500
From: Taral <taral@taral.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 problems with X + USB mouse
Message-ID: <20010923222036.A1685@taral.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have XFree86 4.1.0 and a USB mouse with input core support. On 2.4.9
everything is happy. On 2.4.10 the mouse clicks randomly and jumps to
the bottom left corner a lot. This doesn't affect gpm though, only X.

Any ideas? I've backed down to 2.4.9 for now.

-- 
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose
