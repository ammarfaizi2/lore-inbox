Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263475AbUFUDsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUFUDsv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 23:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbUFUDsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 23:48:51 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:10763 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S263475AbUFUDst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 23:48:49 -0400
Message-ID: <40D65A88.8080601@snapgear.com>
Date: Mon, 21 Jun 2004 13:48:24 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.7-uc0 (MMU-less fixups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.6.7.
A few more things merged in 2.6.7, so only a handful of patches
for general uClinux and m68knommu.

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.7-uc0.patch.gz

Change log:

. merge linux-2.6.7                          me
. more Feith hardware support                Werner Feith
. stop 5282 pit timer from going backwards   me/Felix Daners
. fix PHY race confition in FEC driver       Philippe De Muyter
. fix OOM killer for non-MMU configs         Giovanni Casoli


Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude          EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com























