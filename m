Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTDYVEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263989AbTDYVEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:04:14 -0400
Received: from freeside.toyota.com ([63.87.74.7]:21158 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP id S264309AbTDYVDp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:03:45 -0400
Message-ID: <3EA9A584.7080808@tmsusa.com>
Date: Fri, 25 Apr 2003 14:15:48 -0700
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: Fixed (Was: 2.5.68-mm2+e100=trouble)
References: <3EA97735.8070005@tmsusa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.68-mm2+e100 are now happy together -

Thanks to Andrew Morton for the fix:

delete the __init from the definition of apply_alternatives()

Joe



