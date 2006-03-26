Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWCZKjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWCZKjb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 05:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWCZKjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 05:39:31 -0500
Received: from mail1.skjellin.no ([80.239.42.67]:45456 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S1751249AbWCZKja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 05:39:30 -0500
Message-ID: <44266F61.9050209@tomt.net>
Date: Sun, 26 Mar 2006 12:39:29 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
CC: Linda Walsh <lkml@tlinx.org>
Subject: Re: Save 320K on production machines?
References: <4426515B.5040307@tlinx.org>
In-Reply-To: <4426515B.5040307@tlinx.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linda Walsh wrote:
<snip>
> To minimize
> problems, I disable unused hardware, and all _used_ hardware
> is compiled in (no module loading overhead, no chances for
> arbitrary code insertion).

FYI, rootkits have been able to cope with inserting kernel code without 
using the modules support for ages. It is only makes it marginally harder.

-- 
André Tomt
