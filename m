Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUKVUs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUKVUs2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbUKVUs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:48:26 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:60188 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262391AbUKVUqs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:46:48 -0500
Date: Mon, 22 Nov 2004 21:46:53 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: kbuild/kconfig: [BK PATCH] fixes/updates for 2.6.10
Message-ID: <20041122204653.GA7108@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.
Please include the following in 2.6.10:

o Fix speling error in init/Kconfig
o major update to Documentation/kbuild/modules.txt

To pull:
	bk pull bk://linux-sam.bkbits.net/kbuild

 Documentation/kbuild/modules.txt |  487 +++++++++++++++++++++++++++++++++------
 init/Kconfig                     |    2 
 2 files changed, 420 insertions(+), 69 deletions(-)

	Sam
