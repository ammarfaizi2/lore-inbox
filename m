Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKYDAj>; Fri, 24 Nov 2000 22:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129492AbQKYDAa>; Fri, 24 Nov 2000 22:00:30 -0500
Received: from faun.nada.kth.se ([130.237.222.80]:45764 "EHLO faun.nada.kth.se")
        by vger.kernel.org with ESMTP id <S129153AbQKYC74>;
        Fri, 24 Nov 2000 21:59:56 -0500
Date: Sat, 25 Nov 2000 03:29:53 +0100 (MET)
Message-Id: <200011250229.DAA10442@faun.nada.kth.se>
From: Roland Orre <orre@nada.kth.se>
To: Douglas Gilbert <dougg@torque.net>
Subject: Re: Can't mount SCSI CDROM in 2.4.*
CC: <linux-kernel@vger.kernel.org>
Reply-to: orre@nada.kth.se (Roland Orre)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Gilbert wrote:
> Roland,
> Assuming "sr" is a module and 'lsmod' doesn't
> show it as loaded then what does 'modprove sr_mod'
> report?

Thanks Doug, sometimes I'm totally blind it seems like. 
Of some reason (probably mine fault...) it seems as the flag
CONFIG_BLK_DEV_SR=y
which I've had enabled as long as I can remember of some reason was
missed when I transferred the .config file from 2.2.17 to  2.4.0

       Best regards
       Roland
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
