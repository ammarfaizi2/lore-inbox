Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbVLSUhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbVLSUhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbVLSUhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:37:19 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:17211 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S964958AbVLSUhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:37:18 -0500
Date: Mon, 19 Dec 2005 15:37:01 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 2.6.15-rc6] block: Make CDROMEJECT more robust
In-reply-to: <Pine.LNX.4.64.0512191156430.4827@g5.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, Ben Collins <bcollins@ubuntu.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <1135024621.4541.8.camel@localhost.localdomain>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20051219153236.GA10905@swissdisk.com>
 <20051219193508.GL3734@suse.de>
 <1135021497.2029.3.camel@localhost.localdomain>
 <Pine.LNX.4.64.0512191156430.4827@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 12:02 -0800, Linus Torvalds wrote:

> for the eject case? That way we could do the patch as a pure cleanup, and 
> then a separate patch might change the singe "start_stop 2" with the more 
> complex sequence.
> 
> (IOW, I'd prefer to separate out the cleanup from the "make the eject 
> sequence more complete" part).

Sure thing.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

