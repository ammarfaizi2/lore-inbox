Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313346AbSC2EUO>; Thu, 28 Mar 2002 23:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312964AbSC2EUD>; Thu, 28 Mar 2002 23:20:03 -0500
Received: from andlx-anamika.cisco.com ([64.104.131.189]:50605 "EHLO
	andlx-anamika.cisco.com") by vger.kernel.org with ESMTP
	id <S313346AbSC2ETt>; Thu, 28 Mar 2002 23:19:49 -0500
To: linux-kernel@vger.kernel.org
Subject: Question on Multicast route
From: Ganesan R <rganesan@myrealbox.com>
Date: 29 Mar 2002 09:49:19 +0530
Message-ID: <ueahen09faw.fsf@andlx-anamika.cisco.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 127.0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The route man page gives "route add -net 224.0.0.0 netmask 240.0.0.0 dev eth0"
as the syntax to add a multicast route to the kernel. I remember that this
was needed for the 2.2 kernels (I may be mistaken). Multicasting seems to
work fine on the 2.4 kernels even without this explicit route. Is it still
needed? 

Ganesan

