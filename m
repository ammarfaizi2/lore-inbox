Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314981AbSEHU2W>; Wed, 8 May 2002 16:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSEHU2V>; Wed, 8 May 2002 16:28:21 -0400
Received: from longsword.omniti.com ([216.0.51.134]:57239 "EHLO
	longsword.omniti.com") by vger.kernel.org with ESMTP
	id <S314981AbSEHU2U>; Wed, 8 May 2002 16:28:20 -0400
Message-ID: <3CD98B36.8060203@omniti.com>
Date: Wed, 08 May 2002 16:31:50 -0400
From: Robert Scussel <rscuss@omniti.com>
Reply-To: rscuss@omniti.com
Organization: OmniTI, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 3C509C Odd Behavior
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have read through the list seeing many emails on the 3c59x module, 
however, what I found for the recent posts was for laptops.

Here is the situation

    Tyan S2466 motherboard with 3Com (3c509c) onboard nic, Intel 
eepro100 pci nic.  RedHat 7.2 XFS. When the machine boots, the intel 
card comes up fine. The 3com card appears to initialize, can be seen 
from the box itself, however cannot ping out to anything else, and 
cannot be pinged from anywhere. If I down and up the card twice, it 
comes up fine with no more worries. No errors are generated.  The same 
behavior occurs with the default 2.4.9 kernel that comes with 7.2 
install, and with the 2.4.18 kernel.

Any insights would be most appreciated.

Thanks,
B
-- 
Robert Scussel
1024D/BAF70959/0036 B19E 86CE 181D 0912  5FCC 92D8 1EA1 BAF7 0959

