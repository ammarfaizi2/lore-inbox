Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264755AbUEaUAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264755AbUEaUAP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 16:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264760AbUEaUAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 16:00:15 -0400
Received: from web90003.mail.scd.yahoo.com ([66.218.94.61]:27071 "HELO
	web90003.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S264755AbUEaUAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 16:00:10 -0400
Message-ID: <20040531200008.65043.qmail@web90003.mail.scd.yahoo.com>
Date: Mon, 31 May 2004 13:00:08 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: Ooops w/2.6.7-rc2 & XFS
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040531175151.GA27164@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> repaired == xfs_repair?  what did that say?
ran xfs_repair, no errors reported.

> this machine has ECC/whatever and memtest86 passes
> cleanly right?
ECC 1.5G.  I have already swapped out memeory just to
be on the safe side.

I ran memtest with no errors

> also, when the error occured again was it exactly
> the same both times?

It happened 4 times and every single time, it had the
identical trace.

I brought on line a new volume with new drives to see
if I can reproduce this (same machine and same
kernel).

Any other suggetions/questions?

Thank you for the assistance.

Phy





	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
