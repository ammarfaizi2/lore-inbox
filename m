Return-Path: <linux-kernel-owner+w=401wt.eu-S1753685AbWLRJ55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbWLRJ55 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbWLRJ55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:57:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46961 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753696AbWLRJ5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:57:53 -0500
Subject: [GFS2 & DLM] Pull request
From: Steven Whitehouse <swhiteho@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1166435849.3752.1266.camel@quoit.chygwyn.com>
References: <1166435650.3752.1263.camel@quoit.chygwyn.com>
	 <1166435849.3752.1266.camel@quoit.chygwyn.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 18 Dec 2006 10:01:11 +0000
Message-Id: <1166436072.3752.1269.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please consider pulling the following two compile fixes for GFS2/DLM,

Steve.

------------------------------------------------------------------------------------------
The following changes since commit d1998ef38a13c4e74c69df55ccd38b0440c429b2:
  Ben Collins:
        ib_verbs: Use explicit if-else statements to avoid errors with do-while macros

are found in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes.git

Patrick Caulfield:
      [DLM] fix compile warning

Steven Whitehouse:
      [GFS2] Fix Kconfig

 fs/dlm/lowcomms-tcp.c |    2 +-
 fs/gfs2/Kconfig       |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)


