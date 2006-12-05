Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031389AbWLEVGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031389AbWLEVGd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031405AbWLEVGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:06:33 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:56607 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031389AbWLEVGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:06:32 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4575DF28.6020001@s5r6.in-berlin.de>
Date: Tue, 05 Dec 2006 22:05:44 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jdike@karaya.com,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: GIT pull on work_struct reduction tree
References: <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com>	<24327.1165348363@redhat.com> <20061205121632.65572efb.akpm@osdl.org>
In-Reply-To: <20061205121632.65572efb.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 05 Dec 2006 19:52:43 +0000
> David Howells <dhowells@redhat.com> wrote:
> 
>> I've brought the work_struct reduction patches up to date.  They're in a GIT
>> tree for you to pull when you're ready.
> 
> Given that I (and probably many others) now have a pile of build errors to
> fix, it would be nice to have a short-but-full description of what one must
> do to fix those up, please.

And how is the merge to be timed anyway? IOW will the manual merging
have to be done by people like Andrew and me, or by David, or by Linus?

(I wanted to set up a 2.6.19"-final" based linux1394-2.6.git branch for
Linus to pull from tomorrow or in the latter half of this week. There
will be conflicts between mine and David's stuff, although nothing
serious. I'm just asking to make it as smooth as possible.)
-- 
Stefan Richter
-=====-=-==- ==-- --=-=
http://arcgraph.de/sr/
