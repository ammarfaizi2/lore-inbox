Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbVFJQQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVFJQQe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 12:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVFJQQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 12:16:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:20930 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262595AbVFJQQc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 12:16:32 -0400
Subject: Re: [Jfs-discussion] fsck.jfs segfaults on x86_64
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: jfs-discussion@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ag@m-cam.com
In-Reply-To: <a728f9f905061009097081c0a6@mail.gmail.com>
References: <a728f9f90506100700107976f0@mail.gmail.com>
	 <1118412882.7944.6.camel@localhost>
	 <a728f9f905061007216c38cf4c@mail.gmail.com>
	 <a728f9f905061009097081c0a6@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 11:16:30 -0500
Message-Id: <1118420190.21406.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 12:09 -0400, Alex Deucher wrote:

> 1.1.8 segfaulted as well.

Hmm.  This bothers me.

> running fsck.jfs --omit_journal_replay did the trick!  thanks,

Well, at least it got you going again.  :^)

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

