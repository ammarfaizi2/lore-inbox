Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267487AbUIFF7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267487AbUIFF7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 01:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267505AbUIFF7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 01:59:14 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:12521 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267487AbUIFF7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 01:59:12 -0400
Message-ID: <413BFCB5.4010608@namesys.com>
Date: Sun, 05 Sep 2004 22:59:17 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org, Alexander Zarochentcev <zam@namesys.com>,
       vs <vs@thebsh.namesys.com>
Subject: Re: [PATCH - EXPERIMENTAL] files with forks in the VFS
References: <16699.44411.361938.856856@cse.unsw.edu.au>
In-Reply-To: <16699.44411.361938.856856@cse.unsw.edu.au>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

>As a followup to the multi-branching threads about reiser4, I would
>like to present this patch for discussion and exploration.
>It implements files with fork (which are quite different to files that
>provide different views via a subdirectory structure).
>  
>
How are they different?  Having a distinguished file is consistent with 
the reiser4 approach.

>See Documentation/filesystems/forks.txt (after applying the patch) for more detail.
>
>This is not "how it should be done" but rather "how it could be done",
>and is intended primarily to provide a base for experimentation and
>exploration. 
>
>Below is a sample of what can be done, and then the patch.
>
>NeilBrown
>  
>

