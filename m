Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262719AbSI1FhZ>; Sat, 28 Sep 2002 01:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262720AbSI1FhZ>; Sat, 28 Sep 2002 01:37:25 -0400
Received: from cs6625140-244.austin.rr.com ([66.25.140.244]:9346 "EHLO
	spherenet.dyndns.org") by vger.kernel.org with ESMTP
	id <S262719AbSI1FhZ>; Sat, 28 Sep 2002 01:37:25 -0400
Date: Sat, 28 Sep 2002 00:42:29 -0500
From: Rodney Gordon II <meff@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Inspiron 8200, ICH3M chipset 2.4.19 -- ide0: Speed warnings UDMA 3/4/5 is not functional.
Message-ID: <20020928054229.GA3762@spherenet.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know the drive in the laptop is ATA100 and ever since I tried to
hdparm it, it returns the error "ide0: Speed warnings UDMA 3/4/5 is not
functional." .. Is this for something missing in the ide code? I
remember Vojtek posting a patch for Via chipsets a long time ago so it
seems as if this chipset isn't tagged as 'OK' or something?

-r

-- 
Rodney "meff" Gordon II - meff@pobox.com

-->
Clones are people two.
