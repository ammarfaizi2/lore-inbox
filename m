Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVDDPEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVDDPEn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 11:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVDDPEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 11:04:43 -0400
Received: from mp1-smtp-3.eutelia.it ([62.94.10.163]:20661 "EHLO
	smtp.eutelia.it") by vger.kernel.org with ESMTP id S261253AbVDDPEl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 11:04:41 -0400
Message-ID: <42515787.1050304@eutelia.it>
Date: Mon, 04 Apr 2005 17:04:39 +0200
From: Sergio Chiesa <sergio.chiesa@eutelia.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Ju, Seokmann" <sju@lsil.com>
Subject: Re: Followup: PROBLEM: Kernel bug at tg3.c:2456
References: <0E3FA95632D6D047BA649F95DAB60E57036627A6@exa-atlanta>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57036627A6@exa-atlanta>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ju, Seokmann wrote:

> Can you please specify megaraid driver version?

the v2.4.29 bundled one, v2.10.3.
I'm going to try the last one from your site, the 2.10.9


>>Usually there
>>are no messages on screen, but the last time I get "Kernel bug at
>>tg3.c:2456"!! on the sender. The skb pointer in the tx_ring_info was
>>null.... May it be queue overrun?
> 
> I would suggest to look into the issue from above perspective. 

I found two very old posts (mid 2002) which recall very similar behaviou. I 
didn't find any fix to this two.

http://groups-beta.google.com/group/mlist.linux.kernel/browse_thread/thread/56c3c65c939f0baa/fd63101a0b32ea21?q=tg3&rnum=2#fd63101a0b32ea21
http://groups-beta.google.com/group/mlist.linux.kernel/browse_thread/thread/8b962774c3c5adef/ca778af36b802362?q=tg3&rnum=6#ca778af36b802362


TIA
Sergioc.
