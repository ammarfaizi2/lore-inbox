Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVGSNPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVGSNPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 09:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVGSNPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 09:15:22 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:53511 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S261225AbVGSNPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 09:15:20 -0400
Message-ID: <42DCFEF6.60907@snapgear.com>
Date: Tue, 19 Jul 2005 23:24:06 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.12-uc0 (MMU-less support)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) support against 2.6.12.

Support added for the Freescale Coldfire 5235 CPU family. Still have
a few cleanups of the 68x328 support to submit too.

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.12-uc0.patch.gz


Change log:

. import of linux-2.6.12                       <gerg@snapgear.com>
. support for the Freescale 5235 family        Jate Sujjavanich
. use MAP_PRIVATE for binfmt_flat text maps    <gerg@snapgear.com>


Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com



