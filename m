Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264275AbUFKRtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUFKRtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 13:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbUFKRsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 13:48:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:35976 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264277AbUFKRqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 13:46:14 -0400
Subject: Re: [STACK] >3k call path in reiserfs
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Dave Jones <davej@redhat.com>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <40C9DE9F.90901@namesys.com>
References: <20040609122226.GE21168@wohnheim.fh-wedel.de>
	 <1086784264.10973.236.camel@watt.suse.com>
	 <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com>
	 <1086801345.10973.263.camel@watt.suse.com> <40C75141.7070408@namesys.com>
	 <20040609182037.GA12771@redhat.com> <40C79FE2.4040802@namesys.com>
	 <20040610223532.GB3340@wohnheim.fh-wedel.de> <40C91DA0.6060705@namesys.com>
	 <20040611134621.GA3633@wohnheim.fh-wedel.de>  <40C9DE9F.90901@namesys.com>
Content-Type: text/plain
Message-Id: <1086976005.10973.364.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 11 Jun 2004 13:46:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-11 at 12:32, Hans Reiser wrote:

> Reiser4 is going to obsolete V3 in a few weeks.  V3 will be retained for 
> compatibility reasons only, as V4 blows it away in performance.
> 

This would be the conservative release management you were talking about
before, right?  It's going to take a considerable amount of time for v4
to obsolete v3, because it will take a considerable amount of time for
v4 to become stable under the wide range of conditions that filesystems
get used.

Please don't misunderstand this as a statement against v4, I would love
to see it be 1000x as fast as every other FS.  I'm only asking for some
kind of realism in the expectations you give the users.

-chris


