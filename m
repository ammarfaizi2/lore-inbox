Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265812AbUGITxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUGITxr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 15:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbUGITxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 15:53:47 -0400
Received: from mx1.magmacom.com ([206.191.0.217]:3800 "EHLO mx1.magmacom.com")
	by vger.kernel.org with ESMTP id S265812AbUGITw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 15:52:27 -0400
Subject: Re: 2.6.7-mm7
From: Jesse Stockall <stockall@magma.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: s.rivoir@gts.it, linux-kernel@vger.kernel.org,
       Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <20040709115411.23d96699.akpm@osdl.org>
References: <20040708235025.5f8436b7.akpm@osdl.org>
	 <40EE5418.2040000@gts.it> <20040709024112.7ef44d1d.akpm@osdl.org>
	 <40EE732C.5020404@gts.it> <1089373506.8067.7.camel@homer.blizzard.org>
	 <20040709115411.23d96699.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089402736.8067.12.camel@homer.blizzard.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 09 Jul 2004 15:52:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-09 at 14:54, Andrew Morton wrote:
                      down_write_trylock(&usb_all_devices_rwsem));
> 
> That's a bit unusual.  Could you (or Alan) please explain the reason for
> this a little more?

I believe you want this thread

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108923404032264&w=2

Jesse

-- 
Jesse Stockall <stockall@magma.ca>

