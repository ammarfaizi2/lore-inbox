Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWIWRf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWIWRf3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 13:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWIWRf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 13:35:28 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:13711 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1751342AbWIWRf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 13:35:27 -0400
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, rolandd@cisco.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing includes from infiniband merge
X-Message-Flag: Warning: May contain useful information
References: <20060923154416.GH29920@ftp.linux.org.uk>
From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 23 Sep 2006 10:35:23 -0700
In-Reply-To: <20060923154416.GH29920@ftp.linux.org.uk> (Al Viro's message of "Sat, 23 Sep 2006 16:44:16 +0100")
Message-ID: <ada8xkafpus.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Sep 2006 17:35:26.0721 (UTC) FILETIME=[A80BC710:01C6DF36]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied to my tree.

Sorry about that -- my cross-compilation testbed broke at an
inopportune moment.

 - R.
