Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262879AbSJ1F1e>; Mon, 28 Oct 2002 00:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262881AbSJ1F1e>; Mon, 28 Oct 2002 00:27:34 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:46835 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S262879AbSJ1F1d>; Mon, 28 Oct 2002 00:27:33 -0500
Message-ID: <3DBCCC99.50900@snapgear.com>
Date: Mon, 28 Oct 2002 15:35:21 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: [PATCH]: linux-2.5.44-ac4-uc2 (m68knommu/v850 architecture cleanup)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,

This patch, against patch-2.5.44-ac4, cleans up the m68knommu
and v850 architecture support.

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44-ac4-uc2.patch.gz

It is sorta big. But there is not really anything new in it. Mostly
it is an organizational change of files, and a rewrite of the arch
Makefiles. All much cleaner now.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

