Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268270AbUIKSV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268270AbUIKSV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 14:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268263AbUIKSV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 14:21:26 -0400
Received: from pointblue.com.pl ([81.219.144.6]:24850 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S268270AbUIKSVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 14:21:08 -0400
Message-ID: <4143420B.4040701@pointblue.com.pl>
Date: Sat, 11 Sep 2004 20:20:59 +0200
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Cc: Jakob Oestergaard <jakob@unthought.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Major XFS problems...
References: <20040908123524.GZ390@unthought.net> <4142E3EB.3080308@pointblue.com.pl> <20040911133812.GC32755@krispykreme>
In-Reply-To: <20040911133812.GC32755@krispykreme>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:

>>In my expierence XFS, was right after JFS the worst and the slowest 
>>filesystem ever made.
>>    
>>
>
>On our NFS benchmarks JFS is _significantly_ faster than ext3 and
>reiserfs. It depends on your workload but calling JFS the worst and
>slowest filesystem ever made is unfair.
>  
>

as always, I am speaking for my own and colegues expierence.
We are using dell SMP machines with p3 and p4, different speeds. Plus 
hardware SCSI raid5's.
For samba, and VoIP services, CVS, and mail. Maybe JFS works nicely with 
NFS, but my expierence shows
that XFS  is the slowest among all filesystems vaillia linux 2.6  can 
serve.  JFS was not so extensively tested, but it doesn't do miracles, 
and expierence shows it's rather close to XFS. Reiserfs so far was the 
finest. Maybe because we have pretty much number of files, mostly small 
ones. I don't know.
I didn't ment to hurt anyone's feelings, just giving my opinion on FSs.

Thanks.

--
GJ
