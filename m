Return-Path: <linux-kernel-owner+w=401wt.eu-S965092AbWLOVYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbWLOVYt (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWLOVYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:24:49 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:40457 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965092AbWLOVYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:24:49 -0500
Message-ID: <458312BB.2000600@oracle.com>
Date: Fri, 15 Dec 2006 13:25:15 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: =?UTF-8?B?SsO2cm4gRW5nZWw=?= <joern@lazybastard.org>
CC: Pavel Machek <pavel@ucw.cz>, Scott Preece <sepreece@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/v2] CodingStyle updates
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com> <20061215120942.GA4551@ucw.cz> <4582AEC8.7030608@s5r6.in-berlin.de> <20061215142206.GC2053@elf.ucw.cz> <7b69d1470612150652p609c38d2n9bff58bdb0a1edb7@mail.gmail.com> <20061215150717.GA2345@elf.ucw.cz> <20061215090037.05c021af.randy.dunlap@oracle.com> <20061215201127.GA32210@lazybastard.org> <20061215122659.ebccdede.randy.dunlap@oracle.com> <20061215211014.GB32210@lazybastard.org> <20061215211629.GA317@lazybastard.org>
In-Reply-To: <20061215211629.GA317@lazybastard.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> On Fri, 15 December 2006 21:10:14 +0000, Jörn Engel wrote:
>> Like so?  I manually edited the patch and weakened a few of the space
>> rules, basically the ones in dispute in this thread.
> 
> Btw, this doesn't apply to my git tree at all (just pulled):
> Hunk #1 FAILED at 35.
> Hunk #2 FAILED at 94.
> Hunk #3 succeeded at 145 with fuzz 1 (offset 39 lines).
> Hunk #4 succeeded at 242 with fuzz 2 (offset 82 lines).
> Hunk #5 FAILED at 315.
> Hunk #6 succeeded at 435 with fuzz 2 (offset 96 lines).
> Hunk #7 FAILED at 497.
> Hunk #8 FAILED at 802.
> 5 out of 8 hunks FAILED -- saving rejects to file
> Documentation/CodingStyle.rej
> 
> Is it against -mm or something such?

It's already been merged, so you'll need to make new patches
against -current (as always).

-- 
~Randy
