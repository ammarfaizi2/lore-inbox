Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266028AbUFIXm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUFIXm1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 19:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266031AbUFIXm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 19:42:27 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:16075 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266028AbUFIXmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 19:42:12 -0400
Message-ID: <40C7A07A.1070600@namesys.com>
Date: Wed, 09 Jun 2004 16:42:50 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Chris Mason <mason@suse.com>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
References: <20040609122226.GE21168@wohnheim.fh-wedel.de> <1086784264.10973.236.camel@watt.suse.com> <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com> <20040609172843.GB2950@wohnheim.fh-wedel.de> <40C75273.7020508@namesys.com> <20040609183442.GD2950@wohnheim.fh-wedel.de>
In-Reply-To: <20040609183442.GD2950@wohnheim.fh-wedel.de>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:

>
>
>Since reiser3 won't get many changes anymore and other code should
>generally get enhanced, rather than degraded, you should be pretty
>safe.
>
>Is there a simple way to tell reiser3 functions from reiser4, btw?
>  
>
They are in the reiser4 subdirectory....

>Something similar to ext2/ext3 would be nice.
>
>Jörn
>
>  
>

