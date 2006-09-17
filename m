Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWIQJhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWIQJhy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 05:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWIQJhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 05:37:54 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:24797 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S932417AbWIQJhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 05:37:53 -0400
Date: Sun, 17 Sep 2006 10:37:53 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@sheep.housecafe.de
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc6-mm2: __fscache_register_netfs compile error
In-Reply-To: <Pine.LNX.4.64.0609171022160.27242@sheep.housecafe.de>
Message-ID: <Pine.LNX.4.64.0609171031370.27242@sheep.housecafe.de>
References: <20060912000618.a2e2afc0.akpm@osdl.org>
 <Pine.LNX.4.64.0609171022160.27242@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Sep 2006, Christian Kujau wrote:
> when is enabled, gcc-4.0.3 (ubuntu/dapper, x86_64) gives:
------^ uh, that should read:

"when CONFIG_NFS_FSCACHE is enabled..."

The diff to the old-and-working-config is here:
http://nerdbynature.de/bits/2.6.18-rc6-mm2/config.diff

Christian.
-- 
BOFH excuse #50:

Change in Earth's rotational speed
