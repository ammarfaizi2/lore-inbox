Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130292AbRALJjB>; Fri, 12 Jan 2001 04:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130282AbRALJiv>; Fri, 12 Jan 2001 04:38:51 -0500
Received: from jesus.ksc.co.th ([203.107.130.99]:55049 "EHLO jesus.ksc.co.th")
	by vger.kernel.org with ESMTP id <S130281AbRALJiq>;
	Fri, 12 Jan 2001 04:38:46 -0500
Date: Fri, 12 Jan 2001 16:38:39 +0700
From: Prasong Aroonruviwat <psa@ksc.net.th>
To: linux-kernel@vger.kernel.org
Subject: reset_xmit_timer
Message-ID: <20010112163839.A17010@jesus.ksc.co.th>
Reply-To: psa@ksc.net.th
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

        There're many message from kernel about reset_xmit_timer.
        My system using kernel version 2.4.0.
        I have to concern about it or not? If yes, I'll move down to kernel
    version 2.2.x instead.

        Thanks in advance.

Regards,
Prasong Aroonruviwat

reset_xmit_timer sk=c1b9b9a0 1 when=0x343a, caller=c01d6638
reset_xmit_timer sk=c1b9b9a0 1 when=0x307d, caller=c01d6638
reset_xmit_timer sk=c3163680 1 when=0x3076, caller=c01d6638
reset_xmit_timer sk=c4777cc0 1 when=0x3061, caller=c01d6638
reset_xmit_timer sk=c0a85360 1 when=0x367a, caller=c01d6638
reset_xmit_timer sk=c0b30040 1 when=0x2fe1, caller=c01d6638
reset_xmit_timer sk=c0b30040 1 when=0x300a, caller=c01d6638
reset_xmit_timer sk=c6b589a0 1 when=0x4a5e, caller=c01d6638
reset_xmit_timer sk=c6b589a0 1 when=0x4beb, caller=c01d6638
reset_xmit_timer sk=c6b589a0 1 when=0x3a00, caller=c01d6638
reset_xmit_timer sk=c6b589a0 1 when=0x3256, caller=c01d6638
reset_xmit_timer sk=c6b58040 1 when=0x4ae0, caller=c01d6638
reset_xmit_timer sk=c6b589a0 1 when=0x4ae4, caller=c01d6638
reset_xmit_timer sk=c1b9b9a0 1 when=0x3d0c, caller=c01d6638
reset_xmit_timer sk=c3163360 1 when=0x3cdd, caller=c01d6638
reset_xmit_timer sk=c0b30cc0 1 when=0x31df, caller=c01d6638
reset_xmit_timer sk=c0b30cc0 1 when=0x3986, caller=c01d6638
reset_xmit_timer sk=c0b30cc0 1 when=0x32de, caller=c01d6638
reset_xmit_timer sk=c0b30cc0 1 when=0x32a7, caller=c01d6638
reset_xmit_timer sk=c0b30cc0 1 when=0x38aa, caller=c01d6638
reset_xmit_timer sk=c0b30cc0 1 when=0x34a4, caller=c01d6638
reset_xmit_timer sk=c0a85680 1 when=0x33e0, caller=c01d6638
reset_xmit_timer sk=c0b30cc0 1 when=0x2ffa, caller=c01d6638
reset_xmit_timer sk=c1b9b9a0 1 when=0x3004, caller=c01d6638
reset_xmit_timer sk=c4777360 1 when=0x30f0, caller=c01d6638
reset_xmit_timer sk=c0b30cc0 1 when=0x3090, caller=c01d6638
reset_xmit_timer sk=c4777360 1 when=0x3129, caller=c01d6638
reset_xmit_timer sk=c1b9b9a0 1 when=0x30cd, caller=c01d6638
reset_xmit_timer sk=c0b30cc0 1 when=0x30a5, caller=c01d6638
reset_xmit_timer sk=c1b9b9a0 1 when=0x2ffb, caller=c01d6638
reset_xmit_timer sk=c4777360 1 when=0x2f35, caller=c01d6638
reset_xmit_timer sk=c4777360 1 when=0x3a38, caller=c01d6638
reset_xmit_timer sk=c4777360 1 when=0x3977, caller=c01d6638
reset_xmit_timer sk=c4777360 1 when=0x41cf, caller=c01d6638
reset_xmit_timer sk=c4777360 1 when=0x3e37, caller=c01d6638
reset_xmit_timer sk=c6b58040 1 when=0x4147, caller=c01d6638
reset_xmit_timer sk=c57df360 1 when=0x3c9f, caller=c01d6638
reset_xmit_timer sk=c3163040 1 when=0x3cb6, caller=c01d6638
reset_xmit_timer sk=c6b58040 1 when=0x39a8, caller=c01d6638
reset_xmit_timer sk=c4777cc0 1 when=0x39e5, caller=c01d6638
reset_xmit_timer sk=c4777cc0 1 when=0x3775, caller=c01d6638
reset_xmit_timer sk=c3163680 1 when=0x354e, caller=c01d6638
reset_xmit_timer sk=c3163680 1 when=0x33be, caller=c01d6638
reset_xmit_timer sk=c3163680 1 when=0x3057, caller=c01d6638
reset_xmit_timer sk=c31639a0 1 when=0x3389, caller=c01d6638
reset_xmit_timer sk=c31639a0 1 when=0x2fd1, caller=c01d6638
reset_xmit_timer sk=c6b58040 1 when=0x2fd9, caller=c01d6638
reset_xmit_timer sk=c6b58040 1 when=0x301f, caller=c01d6638
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
