Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265037AbTGCDlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 23:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTGCDlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 23:41:49 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:28434 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S265037AbTGCDlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 23:41:47 -0400
Message-ID: <3F03A958.5060401@snapgear.com>
Date: Thu, 03 Jul 2003 13:56:08 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.74-uc0 (MMU-less support)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) support against 2.5.74.
A few litle updates, still a few patches to send to Linus,
but the number is getting smaller :-)

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.74-uc0.patch.gz


Change Log:
 
    . linux-2.5.74 fixups                me
. DragonEngine cleanups              Georges Menie
. gcc-3.3 cleanups                   Bernardo Innocenti
. fix div64 (for m68knommu)          Bernardo Innocenti

This patch also contains the binfmt_flat shared lib support,
and the DragonEngine compressed image support from previous
-uc patch sets.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com










