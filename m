Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267078AbSKMAzS>; Tue, 12 Nov 2002 19:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267079AbSKMAzS>; Tue, 12 Nov 2002 19:55:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:9118 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267078AbSKMAzS>;
	Tue, 12 Nov 2002 19:55:18 -0500
Message-ID: <3DD1A485.9D93B5A8@digeo.com>
Date: Tue, 12 Nov 2002 17:01:57 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>
Subject: Re: 2.[45] fixes for design locking bug in 
 wait_on_page/wait_on_buffer/get_request_wait
References: <20021112035723.GA17642@dualathlon.random> <3DD0C0E6.4A8035A4@digeo.com> <20021112181532.GA6133@dualathlon.random> <3DD15A79.768C1066@digeo.com> <20021113003312.GF6133@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Nov 2002 01:02:01.0057 (UTC) FILETIME=[45D9BD10:01C28AB0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 

I agreed that the fix was reasonable, and then went on to discuss
broader things.
