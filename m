Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbVIAGil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbVIAGil (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 02:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVIAGik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 02:38:40 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:35599 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S932532AbVIAGik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 02:38:40 -0400
Message-ID: <4316A1FE.9080404@snapgear.com>
Date: Thu, 01 Sep 2005 16:38:54 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.13-uc0 (MMU-less support)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

An update of the uClinux (MMU-less) fixups against 2.6.13.

Strait forward merge of the current outstanding patchs from
2.6.12-uc0. A few updates and fixes, but not alot of change in
this one.

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.13-uc0.patch.gz


Change log:

. import of linux-2.6.13                   <gerg@snapgear.com>
. MOD5272 support                          <jherrero@hvsistemas.es>
. fec driver cleanups                      <phdm@macqel.be>
. 5206eLITE linker script fix              <goor@info.ucl.ac.be>
. update arch/m68knommu/defconfig          <jdittmer@ppp0.net>


Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com




