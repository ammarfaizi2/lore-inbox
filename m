Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbTLEFYT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 00:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263853AbTLEFYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 00:24:19 -0500
Received: from mhub-b1.mrs.umn.edu ([146.57.2.31]:1506 "EHLO
	mhub-b1.mrs.umn.edu") by vger.kernel.org with ESMTP id S263851AbTLEFYT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 00:24:19 -0500
Message-Id: <3FD01679.3040007@mrs.umn.edu>
Date: Thu, 04 Dec 2003 23:24:09 -0600
From: Grant Miner <mine0057@mrs.umn.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: reiserfs-list@namesys.com
CC: linux-kernel@vger.kernel.org
Subject: The x Bit Problem
References: <16333.14692.61778.304155@pc7.dolda2000.com>	 <3FCD47C4.50500@ninja.dynup.net> <3FCE39B8.20307@namesys.com>	 <16334.15412.686909.927196@laputa.namesys.com> <1070580817.8344.140.camel@arabia.home.lan> <3FD00086.90607@ninja.dynup.net>
In-Reply-To: <3FD00086.90607@ninja.dynup.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An interesting thing I discovered is that Windows simply ignores the 'x' 
bit (I should say the Windows equivalent of the 'x' bit, called 
"traverse folder / execute file"), but there is a policy setting that 
overrides this attribute.

I know users get tripped up on this a lot in Unix, like when they don't 
understand why the webserver can't read their public_html directory.  It 
might be a good option for Linux.

