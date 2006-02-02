Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWBBKxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWBBKxr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWBBKxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:53:47 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:25052 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1750727AbWBBKxq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:53:46 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Thu,  2 Feb 2006 11:53:39 +0100
Subject: Re: root=LABEL= problem [Was: Re: Linux Issue]
To: Arjan van de Ven <arjan@infradead.org>
Cc: kavitha s <wellspringkavitha@yahoo.co.in>, linux-kernel@vger.kernel.org
References: <1138863068.3270.6.camel@laptopd505.fenrus.org>,
	<20060201114845.E41F222AF24@anxur.fi.muni.cz>
In-reply-to: <1138863068.3270.6.camel@laptopd505.fenrus.org>
Message-Id: <20060202105338.E921D22AF07@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>On Wed, 2006-02-01 at 12:48 +0100, Jiri Slaby wrote:
>> > ds: no socket drivers loaded!
>> > VFS: Cannot open root device "LABEL=/" or 00:00
>> change root=LABEL=/ to root=/dev/XXX. Vanilla doesn't support this...
>
>ehhh??
>sure it does.
>
>this is not a kernel feature, but an initrd feature, independent on
>which kernel is used (there never was and is not a patch for this in any
>distro kernel I know about)
Ok, thank you for pointing that out.

thanks,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
