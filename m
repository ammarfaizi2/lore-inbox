Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280790AbRKYJd0>; Sun, 25 Nov 2001 04:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280798AbRKYJdQ>; Sun, 25 Nov 2001 04:33:16 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:24214 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280790AbRKYJdD>; Sun, 25 Nov 2001 04:33:03 -0500
Subject: i815 Card ...Machine Freezes
From: Sid Carter <sidcarter@symonds.net>
URL: http://www.symonds.net/~sidcarter/
Operating-System: Turing OS XCVII
Disclaimer: Not speaking for anyone in any way, shape, or form.
Copyright: Copyright 2001 Sid Carter - All Rights Reserved
To: linux-kernel@vger.kernel.org
Reply-To: sidcarter@symonds.net
Organization: Sid Carter Inc.
Date: 25 Nov 2001 15:02:30 +0530
Message-ID: <87adxbxkk1.fsf@toboggan.in.ibm.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My Machine with a Intel i815 card hangs if it is not used for
sometime. The monitor goes blank and after sometime if I don't use the
machine , the system hangs. I can't even use the power switch to
poweroff the machine. I have to pull out the power cable from the back
of the machine. Kernel am using is 2.4.14 with SGi's XFS Patch.

And when I am using X, If I switch from X to console and vice-versa
more than once, my machine hangs. Is this a known problem ? The logs
show no errors at all. Let me know if more info is required.

The relevant output of lspci below:

00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics Controller] (rev 02)

TIA
Regards
        Carter
-- 
The only difference between your girlfriend and a barracuda is the nailpolish.

Sid Carter                                                   Debian GNU/Linux.
