Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUENQwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUENQwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 12:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUENQwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 12:52:51 -0400
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:49628 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S261706AbUENQwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 12:52:50 -0400
Message-ID: <40A4F951.1050602@pobox.com>
Date: Fri, 14 May 2004 12:52:33 -0400
From: Will Dyson <will_dyson@pobox.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] befs i_flags thinko
References: <1084550848.20184.7.camel@thalience> <20040514163613.GD23863@wohnheim.fh-wedel.de>
In-Reply-To: <20040514163613.GD23863@wohnheim.fh-wedel.de>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> On Fri, 14 May 2004 12:07:28 -0400, Will Dyson wrote:
> 
>>This was caught by Jörn Engel <joern@wohnheim.fh-wedel.de> some time
>>ago. It is obviously correct. My public apologies to Jörn for delaying
>>his patch.
> 
> 
> Hey, you just uncovered a race condition, see my mail from 1min ago.
> Not sure if I want to fix such a thing, though. ;)

:)

Heh, your recent mail contains a description. Therefor, that is the one 
that should be used.

-- 
Will Dyson
"Back off man, I'm a scientist!" -Dr. Peter Venkman
