Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263942AbUFKNt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUFKNt0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 09:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUFKNt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 09:49:26 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:36997 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263942AbUFKNtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 09:49:25 -0400
Date: Fri, 11 Jun 2004 15:49:18 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Chris Mason <mason@suse.com>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
Message-ID: <20040611134918.GB3633@wohnheim.fh-wedel.de>
References: <20040609122226.GE21168@wohnheim.fh-wedel.de> <1086784264.10973.236.camel@watt.suse.com> <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com> <20040609172843.GB2950@wohnheim.fh-wedel.de> <40C75273.7020508@namesys.com> <20040609183442.GD2950@wohnheim.fh-wedel.de> <40C7A07A.1070600@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40C7A07A.1070600@namesys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 June 2004 16:42:50 -0700, Hans Reiser wrote:
> J�rn Engel wrote:
> 
> >Is there a simple way to tell reiser3 functions from reiser4, btw?
> > 
> They are in the reiser4 subdirectory....

Does that imply that one cannot build a kernel with both reiser3 and
reiser4 in it?  Or how do you make sure there are not name collisions,
being the namespace expert? ;)

J�rn

-- 
Data expands to fill the space available for storage.
-- Parkinson's Law
