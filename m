Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbRDARhM>; Sun, 1 Apr 2001 13:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132520AbRDARhC>; Sun, 1 Apr 2001 13:37:02 -0400
Received: from imap.digitalme.com ([193.97.97.75]:44341 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S131219AbRDARgm>;
	Sun, 1 Apr 2001 13:36:42 -0400
Message-ID: <3AC758E3.2090507@bigfoot.com>
Date: Sun, 01 Apr 2001 12:35:47 -0400
From: "Trever L. Adams" <trever_Adams@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Serial, 115Kbps, 2.2, 2.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to find out if I am the only one who has pppd drop packets 
as bogus when the port is set at 115Kbps.  I only get it at that speed. 
  It causes stall outs etc.

There may be a possibility this is machine specific, because if it is 
meant to forward the packet to the internal net and I slow the machine 
down (external cache off) it works fine, turn the cache back on and it 
is a problem.

So, anyway, this is an information seeking trip.

Trever

