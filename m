Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWHPQsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWHPQsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWHPQsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:48:13 -0400
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:5311 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1751121AbWHPQsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:48:11 -0400
Message-ID: <44E34C3C.8090406@lwfinger.net>
Date: Wed, 16 Aug 2006 11:47:56 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Michael Buesch <mb@bu3sch.de>, bcm43xx-dev@lists.berlios.de,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: DEBUG_LOCKS_WARN_ON triggered by bcm43xx-SoftMAC
References: <44E296DD.3040803@lwfinger.net> <200608161806.10348.mb@bu3sch.de> <1155745304.3023.55.camel@laptopd505.fenrus.org>
In-Reply-To: <1155745304.3023.55.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2006-08-16 at 18:06 +0200, Michael Buesch wrote:
>> On Wednesday 16 August 2006 05:54, Larry Finger wrote:
>>>
>>> I'm at a loss here. Can anyone explain how to interpret this dump? I
>>> think I see a general protection fault, but what to do from there is a
>>> mystery.
>> Hm, weird bug.
>> I can't reproduce this on i386 or PPC.
>> Could it be a bug in the lockdep code?
> 
> is there anything more in the trace???

No - it picks up with regular log messages at that point.

Larry
