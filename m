Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSI3TJE>; Mon, 30 Sep 2002 15:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261320AbSI3TJE>; Mon, 30 Sep 2002 15:09:04 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:33297 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S261318AbSI3TJD>;
	Mon, 30 Sep 2002 15:09:03 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200209301914.g8UJEIu154087@saturn.cs.uml.edu>
Subject: Re: [ANNOUNCE] procps 2.0.9
To: akpm@digeo.com (Andrew Morton)
Date: Mon, 30 Sep 2002 15:14:17 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <3D989F25.F6605540@digeo.com> from "Andrew Morton" at Sep 30, 2002 11:59:49 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> "Albert D. Cahalan" wrote:

>> Many of the "fixes" have been in Debian's procps for years.
>>
>> Debian's code has been fully maintained for years. It is
>> available in CVS at SourceForge. Let us know what you think
>> of the new "top" program.
>
> Does it support the /proc/stat cleanups which I have queued,
> and the additional /proc/meminfo fields?

Today, no. Next week, yes. Maybe by tonight even...

That's very recent stuff that you sent to the other fork.
BTW, the /proc/meminfo parsing was cleaned up years ago.
You didn't see that clean-up because Red Hat fell asleep
for a few years.
