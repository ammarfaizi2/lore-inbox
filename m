Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbSKVBY2>; Thu, 21 Nov 2002 20:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbSKVBY2>; Thu, 21 Nov 2002 20:24:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57613 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264739AbSKVBYH>;
	Thu, 21 Nov 2002 20:24:07 -0500
Message-ID: <3DDD88BB.209@pobox.com>
Date: Thu, 21 Nov 2002 20:30:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: linux-kernel@vger.kernel.org, kentborg@borg.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
References: <200211220122.gAM1MQY305783@saturn.cs.uml.edu>
In-Reply-To: <200211220122.gAM1MQY305783@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:

> Forget the shred program. It's less useful than having the
> filesystem simply zero the blocks, because it's slow and you
> can't be sure to hit the OS-visible blocks.


Why not?

Please name a filesystem that moves allocated blocks around on you.  And 
point to code, too.

	Jeff



