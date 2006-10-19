Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945927AbWJSOO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945927AbWJSOO0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945934AbWJSOO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:14:26 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:48145 "EHLO
	smtp-vbr10.xs4all.nl") by vger.kernel.org with ESMTP
	id S1945927AbWJSOOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:14:25 -0400
Message-ID: <4537883F.4000305@xs4all.nl>
Date: Thu, 19 Oct 2006 16:14:23 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 w/ GPS time source: worse performance
References: <4534F5F7.8020003@xs4all.nl> <1161103616.2919.70.camel@mindpipe> <45364631.9070805@xs4all.nl> <1161189384.15860.85.camel@mindpipe>            <45365A0B.5030306@xs4all.nl> <200610181957.k9IJvw4m013149@turing-police.cc.vt.edu>
In-Reply-To: <200610181957.k9IJvw4m013149@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Wed, 18 Oct 2006 18:44:59 +0200, Udo van den Heuvel said:
>> It is stuff that is visible by watching ntpq -pn output, by letting mrtg
>> graph stuff, etc. Watch the offset and jitter collumns.
>> Check /usr/sbin/ntpdc -c kerninfo output. Graph that stuff.
> 
> So... you've presumably done that while identifying there is an issue.
> Please share the results.  Have you tried booting back into a 2.6.17
> or so and seen offset/jitter improve?  etc etc etc.

Did not yet try 2.6.17 again since I only shortly have been looking into
this issue.
Other people also see worse performance with 2.6.18 so the need to do
the 2.6.17 thing is a bit less.
