Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265790AbUFIR2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265790AbUFIR2r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 13:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265798AbUFIR2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 13:28:46 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:37042 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265790AbUFIR2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 13:28:45 -0400
Date: Wed, 9 Jun 2004 19:28:43 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Chris Mason <mason@suse.com>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
Message-ID: <20040609172843.GB2950@wohnheim.fh-wedel.de>
References: <20040609122226.GE21168@wohnheim.fh-wedel.de> <1086784264.10973.236.camel@watt.suse.com> <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40C74388.20301@namesys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 June 2004 10:06:16 -0700, Hans Reiser wrote:
> >
> Can you give me some background on whether this is causing real problems 
> for real users?

It's not [yet].  This was done with statical analysis and keeping a
little extra room for safety.  If you prefer to wait for real bug
reports, go ahead...

...but note that my signature ai has proven it's merits once again...

Jörn

-- 
...one more straw can't possibly matter...
-- Kirby Bakken
