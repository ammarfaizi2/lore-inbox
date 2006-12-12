Return-Path: <linux-kernel-owner+w=401wt.eu-S932451AbWLMBf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWLMBf0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 20:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWLMBfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 20:35:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1191 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932451AbWLMBfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 20:35:25 -0500
Date: Wed, 13 Dec 2006 00:35:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: RFC: UML: remove MODE_TT?
Message-ID: <20061212233533.GB28443@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MODE_TT is both marked as deprecated and marked as BROKEN.

Would a patch to remove MODE_TT, always enable MODE_SKAS, and doing all 
possible cleanups after this be accepted?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

