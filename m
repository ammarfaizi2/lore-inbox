Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbWGNHFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWGNHFp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 03:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWGNHFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 03:05:45 -0400
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:50573 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1161033AbWGNHFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 03:05:45 -0400
Message-ID: <44B7424C.3000108@namesys.com>
Date: Fri, 14 Jul 2006 00:05:48 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Reiserfs mail-list <Reiserfs-List@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: short term task list for Reiser4
References: <44B42064.4070802@namesys.com> <Pine.LNX.4.64.0607131215310.28976@schroedinger.engr.sgi.com> <44B6A4A2.2070401@namesys.com> <Pine.LNX.4.64.0607131310570.29555@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607131310570.29555@schroedinger.engr.sgi.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>On Thu, 13 Jul 2006, Hans Reiser wrote:
>
>  
>
>>Christoph Lameter wrote:
>>
>>    
>>
>>>Will there be any NUMA /SMP fixes? Reiserfs performance is severely 
>>>impacted at higher processor counts by the mandatory centralized locking 
>>>in both read and write paths in the filesystem.
>>>      
>>>
>>Reiserfs or Reiser4?
>>    
>>
>
>Either.
> 
>
>
>  
>
What big locks are you running into in V4?  Please tell me more.

Hans
