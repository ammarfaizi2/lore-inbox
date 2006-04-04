Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751842AbWDDIbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWDDIbO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 04:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbWDDIbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 04:31:14 -0400
Received: from mail02.hansenet.de ([213.191.73.62]:40443 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP
	id S1751842AbWDDIbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 04:31:13 -0400
Message-ID: <44322EC5.5030006@e-dict.net>
Date: Tue, 04 Apr 2006 10:31:01 +0200
From: Ingo Freund <Ingo.Freund@e-dict.net>
Reply-To: linux-kernel-news@e-dict.net
Organization: e-dict GmbH & Co. KG
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: out of memory
References: <4431001C.5080905@e-dict.net> <20060403204048.092db2cc.akpm@osdl.org>
In-Reply-To: <20060403204048.092db2cc.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ingo Freund <Ingo.Freund@e-dict.net> wrote:
>> Apr  2 10:56:11 dbm kernel: 8538 pages slab
> 
> and it's not in slab.
> 
>> Apr  2 10:56:11 dbm kernel: Symbols match kernel version 2.6.13.
> 
> Boy, 2.6.13 was a long time ago - I'm sure we fixed many leaks since then,
> but I do not recall any particular patch which might fix this, sorry.
> 
> Your best option would be to seek a kernel upgrade.

I'll give a try to the last kernel version

Is there a way to get those kernel/memory information from time
to time from the running system which I found in the syslog file?

Thank you
Ingo.
