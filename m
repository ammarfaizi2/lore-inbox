Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264225AbUFKQxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264225AbUFKQxS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbUFKQwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:52:50 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:32148 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264225AbUFKQuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:50:35 -0400
Date: Fri, 11 Jun 2004 18:50:20 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Dave Jones <davej@redhat.com>, Chris Mason <mason@suse.com>,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
Message-ID: <20040611165020.GC11755@wohnheim.fh-wedel.de>
References: <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com> <1086801345.10973.263.camel@watt.suse.com> <40C75141.7070408@namesys.com> <20040609182037.GA12771@redhat.com> <40C79FE2.4040802@namesys.com> <20040610223532.GB3340@wohnheim.fh-wedel.de> <40C91DA0.6060705@namesys.com> <20040611134621.GA3633@wohnheim.fh-wedel.de> <40C9DE9F.90901@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40C9DE9F.90901@namesys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 June 2004 09:32:31 -0700, Hans Reiser wrote:
> >
> Reiser4 is going to obsolete V3 in a few weeks.  V3 will be retained for 
> compatibility reasons only, as V4 blows it away in performance.

About three years ago, I switched from reiserfs to ext3.  And still, I
have some old reiserfs partitions around that I use.  Either I'm quite
unusual or reiser3 will stay around for a while. :)

> You are right though that OpenBSD does some things better.

For sure.  And still, I use and develop for Linux.

Jörn

-- 
When people work hard for you for a pat on the back, you've got
to give them that pat.
-- Robert Heinlein
