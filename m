Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130833AbRATWqn>; Sat, 20 Jan 2001 17:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130758AbRATWqd>; Sat, 20 Jan 2001 17:46:33 -0500
Received: from vitelus.com ([64.81.36.147]:21256 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S130833AbRATWqS>;
	Sat, 20 Jan 2001 17:46:18 -0500
Date: Sat, 20 Jan 2001 14:46:16 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4 and ipmasq modules
Message-ID: <20010120144616.A16843@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was great to see that 2.4.0 reintroduced ipfwadm support! I had no
need for ipchains and ended up using the wrapper around it that
emulated ipfwadm. However, 2.[02].x used to have "special IP
masquerading modules" such as ip_masq_ftp.o, ip_masq_quake.o, etc. I
can't find these in 2.4.0. Where have they gone? Without important
modules such as ip_masq_ftp.o I cannot use non-passive ftp from behind
the masquerading firewall.

Thanks,
Aaron Lehmann
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
