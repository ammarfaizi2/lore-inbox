Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVC2Kha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVC2Kha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVC2Ker
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:34:47 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:3994 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262307AbVC2Kdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:33:37 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Li Shaohua <shaohua.li@intel.com>
Subject: Re: 2.6.12-rc1-mm3: box hangs solid on resume from disk while resuming device drivers
Date: Tue, 29 Mar 2005 12:33:39 +0200
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <16A54BF5D6E14E4D916CE26C9AD30575017EDC38@pdsmsx402.ccr.corp.intel.com> <200503261923.52020.rjw@sisk.pl> <1111972933.28620.7.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1111972933.28620.7.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503291233.40193.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 28 of March 2005 03:22, Li Shaohua wrote:
> On Sun, 2005-03-27 at 02:23, Rafael J. Wysocki wrote:
]--snip--[ 
> Could you please file a bug in bugzilla? I don't want to lose the
> context of thread. And please attach your acpidmp output in the bug.

The bug report is at:

http://bugzilla.kernel.org/show_bug.cgi?id=4416

I've put there all the information related to it that I've already collected.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
