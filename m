Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWDJX01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWDJX01 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 19:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWDJX00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 19:26:26 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:47843 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932171AbWDJX00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 19:26:26 -0400
Date: Mon, 10 Apr 2006 17:25:26 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH -rt] Buggy uart (for 2.6.16)
In-reply-to: <60bbB-6XU-17@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: rostedt@goodmis.org
Message-id: <443AE966.8050203@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <604MF-5Tc-7@gated-at.bofh.it> <6083V-2pi-9@gated-at.bofh.it>
 <60bbB-6XU-17@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> I just found some more information.   The board's chipset is an Intel
> 440BX.  I think this is responsible for the uarts.

No, it would be whatever Super I/O chip is present on the board.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

