Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWAEBKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWAEBKG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWAEBKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:10:05 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:45951 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751084AbWAEBKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:10:04 -0500
Message-ID: <43BC71CC.5050307@oracle.com>
Date: Wed, 04 Jan 2006 17:09:32 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Joel Becker <Joel.Becker@oracle.com>,
       Arjan van de Ven <arjan@infradead.org>, Christoph Hellwig <hch@lst.de>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: merging ocfs2?
References: <43BAF93A.10509@oracle.com> <Pine.LNX.4.64.0601041649270.3668@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601041649270.3668@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>
> On Tue, 3 Jan 2006, Zach Brown wrote:

>>  http://oss.oracle.com/git/ocfs2.git
>
> If Christoph is happy with it, and there has been no grumbling from -mm, I
> can certainly merge it.
>
> However, I really _really_ prefer that people who use git to merge use the
> native git protocol, which I trust. That http: thing may work, but it's a
> cludge ;)
>
> Can you run git-daemon on the machine?

Hmm, that's a good question.  I fear that machine is hiding in some firewalled
bunker somewhere.  Joel?

- z

