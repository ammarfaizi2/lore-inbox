Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTJNNQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 09:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTJNNQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 09:16:15 -0400
Received: from tartutest.cyber.ee ([193.40.6.70]:7428 "EHLO tartutest.cyber.ee")
	by vger.kernel.org with ESMTP id S262288AbTJNNQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 09:16:14 -0400
From: Meelis Roos <mroos@linux.ee>
To: thomas@winischhofer.net, linux-kernel@vger.kernel.org
Subject: Re: gcc -msoft-float [Was: Linux 2.6.0-test7 - stability freeze]
In-Reply-To: <3F8BBCF7.5020006@winischhofer.net>
User-Agent: tin/1.7.2-20031002 ("Berneray") (UNIX) (Linux/2.6.0-test7 (i686))
Message-Id: <E1A9P22-0000D2-UX@rhn.tartu-labor>
Date: Tue, 14 Oct 2003 16:16:10 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

TW> This is a framebuffer driver and like all fbdev-related stuff it is 
TW> properly maintained in the fbdev-tree, waiting to merged into mainline.

Since James seems busy, someone should step up, split these changes into
patches, test (or let people test) them separately and submit to kernel.
Of course in coordination with James, he knows hat should be stable and
what not. I would take this myself by have not enough time.

-- 
Meelis Roos (mroos@linux.ee)
