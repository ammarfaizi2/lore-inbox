Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTLAJmC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 04:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTLAJmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 04:42:01 -0500
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:59274 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262427AbTLAJl7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 04:41:59 -0500
Message-ID: <3FCB0D6A.3030503@stesmi.com>
Date: Mon, 01 Dec 2003 10:44:10 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Nathan Scott <nathans@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS for 2.4
References: <20031201062052.GA2022@frodo> <20031201092446.GK6454@suse.de>
In-Reply-To: <20031201092446.GK6454@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Mon, Dec 01 2003, Nathan Scott wrote:
> 
>>Hi Marcelo,
>>
>>Please do a
>>
>>	bk pull http://xfs.org:8090/linux-2.4+coreXFS
>>
>>This will merge the core 2.4 kernel changes required for supporting
>>the XFS filesystem, as listed below.  If this all looks acceptable,
>>then please also pull the filesystem-specific code (fs/xfs/*)
>>
>>	bk pull http://xfs.org:8090/linux-2.4+justXFS
> 
> 
> Where can these be found as a unified diff? It's quite bothersome to
> have to pull a changeset just to review it (cloning a kernel tree
> first), not to mention space intensive.
> 

There was a mail announcing split-patches for 2.4.23 five hours before
this mail. The mail was from Keith Owens but here's the link from it:

ftp://oss.sgi.com/projects/xfs/patches/2.4.23 for the 2.4.23 patches.

// Stefan

