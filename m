Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbULNWLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbULNWLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbULNWIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:08:54 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:48875 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261689AbULNWCj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:02:39 -0500
Message-ID: <41BF6313.7040207@verizon.net>
Date: Tue, 14 Dec 2004 17:02:59 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/kernel-docs.txt update
References: <41BE1443.3000205@verizon.net> <41BE14FD.20008@osdl.org>
In-Reply-To: <41BE14FD.20008@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [209.158.220.243] at Tue, 14 Dec 2004 16:02:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> Jim Nelson wrote:
> 
>> Apologies for the gzip'ed attachment - many spamfilters don't like all 
>> the URL's in this file.
>>
>> The large number of changes are the result of the site author's 
>> suggestion of using `lynx -dump 
>> http://www.dit.upm.es/~jmseyas/linux/kernel/hackers-docs.html` as the 
>> file source.
> 
> 
> The URL updates and other corrections are good, of course,
> but changing the right margin from approx. 70 to sometimes
> near 80 is not good IMO and should not be done.
> 

Right.  It was originally formatted with a 74 character margin. I will post a 
re-worked patch forthwith.

Jim
