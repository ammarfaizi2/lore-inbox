Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUASKpc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 05:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbUASKpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 05:45:32 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:32154 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264501AbUASKpb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 05:45:31 -0500
Message-ID: <400BB549.3040904@namesys.com>
Date: Mon, 19 Jan 2004 13:45:29 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: raymond jennings <highwind747@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA] - run-length compaction of block numbers
References: <BAY1-F117hxeH6PC8MS00006f92@hotmail.com> <200401161954.i0GJsEgj003906@turing-police.cc.vt.edu>            <40084DFB.5040106@namesys.com> <200401162238.i0GMcxT3004785@turing-police.cc.vt.edu>
In-Reply-To: <200401162238.i0GMcxT3004785@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Fri, 16 Jan 2004 23:47:55 +0300, Hans Reiser said:
>
>  
>
>>This is already done, they are called "extent"s.  Reiser4 uses them, XFS 
>>uses them, I think Veritas may have been the first to use them but I am 
>>not sure of this, maybe it was IBM.
>>    
>>
>
>Does the extent-based disk allocation used by OS/360 in 1964 count? :)
>  
>
Probably.  Tell me more about it.

-- 
Hans


