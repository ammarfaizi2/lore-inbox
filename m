Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbTENW1G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTENW1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:27:06 -0400
Received: from mail.gmx.de ([213.165.64.20]:2313 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262021AbTENW1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:27:05 -0400
Message-ID: <3EC2C5AC.6050709@gmx.net>
Date: Thu, 15 May 2003 00:39:40 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21rc2aa1
References: <20030514202258.GF1429@dualathlon.random>
In-Reply-To: <20030514202258.GF1429@dualathlon.random>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> Only in 2.4.21rc2aa1: 00_remove_inode_page-prune_icache-smp-race-1
> 
> 	Fix mm corrupting SMP race between remove_inode_page and prune_icache.
> 	Found by Chris Mason.

Any chance this will get into mainline before 2.4.21?


Regards,
Carl-Daniel

