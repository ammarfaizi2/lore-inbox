Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWFNN3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWFNN3N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWFNN3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:29:13 -0400
Received: from 8.ctyme.com ([69.50.231.8]:25788 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S964915AbWFNN3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:29:12 -0400
Message-ID: <44900F27.7010103@perkel.com>
Date: Wed, 14 Jun 2006 06:29:11 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Visionary ideas for SQL file systems
References: <448F8F18.4030200@perkel.com> <448FFCAD.8010205@mail.ru>
In-Reply-To: <448FFCAD.8010205@mail.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Michael Raskin wrote:
> Marc Perkel wrote:
>> I'm going to throw this idea out there just to get people thinking. 
>> There's nothing in reality that is like this except maybe some of the 
>> ReiserFS ideas, but I want to take the idea farther. the idea is ......
>>
>> Why not put an SQL filesystem directly on a block devices where files 
>> are really blobs within the filesystem and file names and file 
>> attributes are all indexed data withing the SQL database. The 
>> operating system will have SQL built in.
> Maybe it is better done by fuse? So, did you consider contributing to 
> RelFS or something like it? Try FUSE.sf.net to find out the present 
> fs-in-usermode projects.
>

That certianly looks like a good tool to start experimenting with.

