Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbSJJQZv>; Thu, 10 Oct 2002 12:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbSJJQZv>; Thu, 10 Oct 2002 12:25:51 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:63116 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261700AbSJJQZu>;
	Thu, 10 Oct 2002 12:25:50 -0400
Message-ID: <3DA5AB6B.80506@colorfullife.com>
Date: Thu, 10 Oct 2002 18:31:39 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Dow, Benjamin" <bdow@itouchcom.com>
CC: linux-kernel@vger.kernel.org
Subject: RE: kernel memory leak?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >
 > /proc/slabinfo reports that buffer_head increases by 4k, but
 > those are the only changes)
 >
4k or one object? the first column ist the number of objects, not 4k.

--
	Manfred

