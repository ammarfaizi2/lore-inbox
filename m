Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbUEQRYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUEQRYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 13:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUEQRYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 13:24:53 -0400
Received: from mail.appliedminds.com ([65.104.119.58]:2767 "EHLO
	appliedminds.com") by vger.kernel.org with ESMTP id S261937AbUEQRYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 13:24:14 -0400
Message-ID: <40A8F515.6010008@appliedminds.com>
Date: Mon, 17 May 2004 10:23:33 -0700
From: James Lamanna <jamesl@appliedminds.com>
User-Agent: Mozilla Thunderbird 0.6+ (X11/20040421)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: i810fb cursor not working properly
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed when the i810fb has been running under 2.6.5 that the 
cursor does not follow any keyboard commands (e.g. h/j/k/l in vi), but 
instead sits at its last known location.
However, if you start typing at a console or in Insert mode in vi, the 
cursor then moves with the text that you are typing.

Any ideas?

Thanks.
-- 
James Lamanna
