Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131253AbRAXWU6>; Wed, 24 Jan 2001 17:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130030AbRAXWUs>; Wed, 24 Jan 2001 17:20:48 -0500
Received: from w240.z209220232.was-dc.dsl.cnc.net ([209.220.232.240]:13063
	"EHLO yendi.dmeyer.net") by vger.kernel.org with ESMTP
	id <S132526AbRAXWUj>; Wed, 24 Jan 2001 17:20:39 -0500
Date: Wed, 24 Jan 2001 17:20:38 -0500
From: dmeyer@dmeyer.net
To: linux-kernel@vger.kernel.org
Subject: when is overriding idebus safe?
Message-ID: <20010124172038.A1431@jhereg.dmeyer.net>
Reply-To: dmeyer@dmeyer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Organization: dmeyer.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel always says:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

at boot time.  How would I know if it's safe to say idebus=66?  The
documentation is fairly vague on this.

    Thanks,
    Dave

-- 
David M. Meyer
dmeyer@dmeyer.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
