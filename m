Return-Path: <linux-kernel-owner+w=401wt.eu-S1161304AbWLPSCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161304AbWLPSCE (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 13:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161306AbWLPSCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 13:02:04 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:57048 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161304AbWLPSCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 13:02:03 -0500
Message-ID: <458434B0.4090506@oracle.com>
Date: Sat, 16 Dec 2006 10:02:24 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       hpa@zytor.com, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
References: <20061214223718.GA3816@elf.ucw.cz>	<20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org>
In-Reply-To: <20061216095702.3e6f1d1f.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sat, 16 Dec 2006 09:44:21 -0800
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> 
>> On Thu, 14 Dec 2006 23:37:18 +0100 Pavel Machek wrote:
>>
>>> Hi!
>>>
>>> pavel@amd:/data/pavel$ finger @www.kernel.org
>>> [zeus-pub.kernel.org]
>>> ...
>>> The latest -mm patch to the stable Linux kernels is: 2.6.19-rc6-mm2
>>> pavel@amd:/data/pavel$ head /data/l/linux-mm/Makefile
>>> VERSION = 2
>>> PATCHLEVEL = 6
>>> SUBLEVEL = 19
>>> EXTRAVERSION = -mm1
>>> ...
>>> pavel@amd:/data/pavel$
>>>
>>> AFAICT 2.6.19-mm1 is newer than 2.6.19-rc6-mm2, but kernel.org does
>>> not understand that.
>> Still true (not listed) for 2.6.20-rc1-mm1  :(
>>
>> Could someone explain what the problem is and what it would
>> take to correct it?
> 
> 2.6.20-rc1-mm1 still hasn't propagated out to the servers (it's been 36
> hours).  Presumably the front page non-update is a consequence of that.

Agreed on the latter part.  Can someone address the real problem???

-- 
~Randy
