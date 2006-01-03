Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWACWXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWACWXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 17:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWACWXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 17:23:00 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:63720 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751494AbWACWW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 17:22:59 -0500
Message-ID: <43BAF93A.10509@oracle.com>
Date: Tue, 03 Jan 2006 14:22:50 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Joel Becker <Joel.Becker@oracle.com>,
       Arjan van de Ven <arjan@infradead.org>, Christoph Hellwig <hch@lst.de>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Mark Fasheh <mark.fasheh@oracle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: merging ocfs2?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Linus,

Now that 2.6.15 has been released, can we merge ocfs2?  It's been in -mm
and as far as we know we've addressed all the concerns that were brought
up by reviewers.

To recap, it's a general purpose clustered file system -- it does not
have Oracle hooks or anything sneaky like that.

Joel has done the heavy lifting to bring its git repository up to date
so one should be able to pull from:

  http://oss.oracle.com/git/ocfs2.git

If there's anything further that is needed from us (Mark, Joel, myself),
please let us know.

- z
