Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbTH2TLx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 15:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbTH2TLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 15:11:53 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:5781 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S261675AbTH2TLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:11:52 -0400
Message-ID: <3F4FA577.4050207@genebrew.com>
Date: Fri, 29 Aug 2003 15:11:51 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shantanu Goel <sgoel01@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [VM PATCH] Faster reclamation of dirty pages and unused inode/dcache
 entries in 2.4.22
References: <20030829150111.72151.qmail@web12802.mail.yahoo.com>
In-Reply-To: <20030829150111.72151.qmail@web12802.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shantanu Goel wrote:

> Feedback and comments are welcome.

This is an optimization patch. Since the VM is all voodoo :), there are 
no obvious improvements. Numbers and/or test scripts would go a long way 
in getting acceptance.

-Rahul
-- 
Rahul Karnik
rahul@genebrew.com
http://www.genebrew.com/

