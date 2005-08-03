Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVHCEcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVHCEcJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 00:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbVHCEcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 00:32:09 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:56653 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S262043AbVHCEcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 00:32:07 -0400
Message-ID: <42F048B5.8030000@m1k.net>
Date: Wed, 03 Aug 2005 00:31:49 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Bodo Eggert <7eggert@gmx.de>, Steven Rostedt <rostedt@goodmis.org>,
       Sean Bruno <sean.bruno@dsl-only.net>, Lee Revell <rlrevell@joe-job.com>,
       webmaster@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Testing RC kernels [KORG]
References: <Pine.LNX.4.58.0508030214150.7510@be1.lrz> <42F04632.5070109@zytor.com>
In-Reply-To: <42F04632.5070109@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> Bodo Eggert wrote:
>
>>
>> I hacked some changes to create vogon-compatibility. Maybe you like it.
>> I'm not completely happy, but it's too late now.
>>
>> Changes:
>> - Make first column more terse
>> - Move full download links to a seperate table, where they can be found.
>> - Add <h2> headings above the patches and above the tarballs
>> - Add some hints
>> - Create a dead link to a patching-HOWTO
>> - Add a 'applies to:' column
>> - fix legend to match changes
>>
>
> This is completely useless.  The issue isn't the formatting, the issue 
> is to make yet another change to an already hard-to-maintain set of 
> scripts.
>
>     -hpa

Why not just have the scripts plug values into a database, and have the 
html/php be formatted like Bodo suggests, and reads content from database?
Very simple, less maintenance... Only requires 1 initial redesign, and 
easier maintainence of the scripts that you speak of.

-- 
Michael Krufky

