Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265915AbRF3Ngi>; Sat, 30 Jun 2001 09:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265954AbRF3Ng2>; Sat, 30 Jun 2001 09:36:28 -0400
Received: from eising.k-net.dtu.dk ([130.225.71.229]:43716 "EHLO
	eising.k-net.dk") by vger.kernel.org with ESMTP id <S265915AbRF3NgJ>;
	Sat, 30 Jun 2001 09:36:09 -0400
Date: Sat, 30 Jun 2001 15:39:12 +0200
From: Martin Clausen <martin@ostenfeld.dk>
To: linux-kernel@vger.kernel.org
Subject: Maximum socket buffer sizes
Message-ID: <20010630153912.C1352@ostenfeld.dk>
Reply-To: Martin Clausen <martin@ostenfeld.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

What are the maximum socket buffer sizes for:

net.core.rmem.*
net.core.wmem.*
net.core.optmem_max

As far as i can tell these are ones to adjust when "tuning" 
e.g. the netlink sockets between the kernel and userspace?

I have not been able to find this information anywhere...

Best regards
Martin

-- 
Failure is not an option. It comes bundled with your Microsoft product.
