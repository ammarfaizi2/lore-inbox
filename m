Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268734AbUJKJfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268734AbUJKJfR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 05:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268735AbUJKJfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 05:35:17 -0400
Received: from gw.pasop.tomt.net ([80.239.42.1]:49133 "EHLO puppen.tomt.net")
	by vger.kernel.org with ESMTP id S268734AbUJKJfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 05:35:13 -0400
Message-ID: <416A53D3.9020002@tomt.net>
Date: Mon, 11 Oct 2004 11:35:15 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, 
>  trying to make ready for the real 2.6.9 in a week or so, so please give
> this a beating, and if you have pending patches, please hold on to them
> for a bit longer, until after the 2.6.9 release. It would be good to have
> a 2.6.9 that doesn't need a dot-release immediately ;)

The data corruption bug in the new megaraid driver version seems still 
not to be fixed. LSI posted a fix some weeks ago, not sure how that went..

"[PATCH]: megaraid 2.20.4: Fixes a data corruption bug"
