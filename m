Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130677AbQKVRcT>; Wed, 22 Nov 2000 12:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130800AbQKVRcJ>; Wed, 22 Nov 2000 12:32:09 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:36624 "EHLO
        alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
        id <S130677AbQKVRcD>; Wed, 22 Nov 2000 12:32:03 -0500
From: Norbert Preining <preining@logic.at>
Date: Wed, 22 Nov 2000 18:01:51 +0100
To: linux-kernel@vger.kernel.org
Subject: isofs Problems with test11-final
Message-ID: <20001122180151.A3530@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

Reading of devices with isofs fs is not working, listing of 0 files
and the following msgs in the logfile:
_isofs_bmap: block < 0
_isofs_bmap: block >= EOF (1633681408, 10240)
_isofs_bmap: block >= EOF (1633681408, 4096)

Is there any fix?

(Please Cc: answers to me, thanks)

Best wishes

Norbert
-- 
ciao
norb

+-------------------------------------------------------------------+
| Norbert Preining              http://www.logic.at/people/preining |
| University of Technology Vienna, Austria        preining@logic.at |
| DSA: 0x09C5B094 (RSA: 0xCF1FA165) mail subject: get [DSA|RSA]-key |
+-------------------------------------------------------------------+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
