Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTEVLzM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 07:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTEVLzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 07:55:11 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:57093 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261807AbTEVLzK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 07:55:10 -0400
Message-ID: <3ECCBD6B.9070807@aitel.hist.no>
Date: Thu, 22 May 2003 14:07:07 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm8
References: <20030522021652.6601ed2b.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm8/
> 
> . One anticipatory scheduler patch, but it's a big one.  I have not stress
>   tested it a lot.  If it explodes please report it and then boot with
>   elevator=deadline.
> 
> . The slab magazine layer code is in its hopefully-final state.
> 
> . Some VFS locking scalability work - stress testing of this would be
>   useful.


It seems to work fine for UP and survives a kernel compile.

Helge Hafting


