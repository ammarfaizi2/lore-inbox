Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUAMIuO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 03:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUAMIuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 03:50:14 -0500
Received: from util.ext.ti.com ([192.91.75.135]:12174 "EHLO util.ext.ti.com")
	by vger.kernel.org with ESMTP id S261812AbUAMIuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 03:50:11 -0500
From: "Sirotkin, Alexander" <demiurg@ti.com>
To: linux-kernel@vger.kernel.org
X-Accept-Language: en-us, en
Message-ID: <4003B134.7040707@ti.com>
Date: Tue, 13 Jan 2004 10:49:56 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: skb fragmentation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen a couple of drivers (for instance - e100) using fragmented skb 
on transmit path.
I was wondering, how one can do the same on receive  ?

Anybody ever tried to do this ? Is there any example of such a driver ?

-- 
Alexander Sirotkin
SW Engineer

Texas Instruments
Broadband Communications Israel (BCIL)
Tel:  +972-9-9706587
________________________________________________________________________
"Those who do not understand Unix are condemned to reinvent it, poorly."
      -- Henry Spencer 

