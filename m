Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTFXKnG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 06:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTFXKnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 06:43:06 -0400
Received: from [62.75.136.201] ([62.75.136.201]:40855 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261868AbTFXKmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 06:42:18 -0400
Message-ID: <3EF82E49.1080503@g-house.de>
Date: Tue, 24 Jun 2003 12:56:09 +0200
From: Christian Kujau <evil@g-house.de>
Reply-To: evil@g-house.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4b) Gecko/20030507
X-Accept-Language: de, en
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at jfs_dmap.c:776
References: <3EF721C0.9010801@g-house.de> <200306231309.36133.shaggy@austin.ibm.com>
In-Reply-To: <200306231309.36133.shaggy@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp schrieb:
> JFS is broken when the page size is greater than 4K, as is the case for 
> Alpha.  This needs to be fixed, but I've put it off since I haven't had 
> ready access to the right hardware, and I haven't had any success 
> trying to boot a i386 kernel with a larger page size.  I'll try to find 
> the time to work on this within the next couple weeks.

ok, fine :-)

thank you,
Christian.

