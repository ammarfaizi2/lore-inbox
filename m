Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTDVRaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 13:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTDVRap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 13:30:45 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4992 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263277AbTDVRam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 13:30:42 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304221745.h3MHjA8m000202@81-2-122-30.bradfords.org.uk>
Subject: Re: objrmap and vmtruncate
To: mbligh@aracnet.com (Martin J. Bligh)
Date: Tue, 22 Apr 2003 18:45:10 +0100 (BST)
Cc: mingo@redhat.com (Ingo Molnar), akpm@digeo.com (Andrew Morton),
       andrea@suse.de (Andrea Arcangeli), mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, torvalds@transmeta.com (Linus Torvalds),
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <182180000.1051028196@[10.10.2.4]> from "Martin J. Bligh" at Apr 22, 2003 09:16:37 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > make almost zero noticeable difference on a 768 MB system - i have a 768
> > MB system. Whether 1MB of extra RAM to a 128 MB system will make more of a
> > difference than a predictable VM - i dont know, it probably depends on the
> > app, but i'd go for more RAM. But it will make a _hell_ of a difference on
> > a 1 TB RAM 64-bit system where the sharing factor explodes. And that's
> > where Linux usage we will be by the time 2.6 based systems go production.

> You obviously have a somewhat different timeline in mind for 2.6 than the
> rest of us ;-)

It's certainly where Linux usage will be before 2.8 is ready.

(and anyway, I'm sure there's a subsystem that we haven't _yet_
re-written during the feature freeze...  :-) )


John.
