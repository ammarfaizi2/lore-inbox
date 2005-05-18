Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVERXhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVERXhC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 19:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVERXgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 19:36:54 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:31412 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262405AbVERXfX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 19:35:23 -0400
Message-ID: <428BD137.1020200@namesys.com>
Date: Wed, 18 May 2005 16:35:19 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Fasheh <mark.fasheh@oracle.com>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, torvalds@osdl.org, akpm@osdl.org,
       wim.coekaerts@oracle.com, lmb@suse.de
Subject: Re: [RFC] [PATCH] OCFS2
References: <20050518223303.GE1340@ca-server1.us.oracle.com>
In-Reply-To: <20050518223303.GE1340@ca-server1.us.oracle.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fasheh wrote:

>In case there is any concern about code size, a quick comparison shows
>the file system and cluster stacks combined size to be not
>significantly larger than reiserfs and 1/3 the size of xfs.
>
>  
>
I too am quick to cite XFS when anyone complains about the code size of
anything we write.;-)

Congrats on getting a filesystem to start to work, I know how long that
road is, and  best of luck to you all,

Hans
