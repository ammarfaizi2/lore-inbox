Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264076AbUDGDjb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 23:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbUDGDjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 23:39:31 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:45072 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S264076AbUDGDj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 23:39:29 -0400
Message-ID: <40737800.9010503@snapgear.com>
Date: Wed, 07 Apr 2004 13:39:44 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.5-uc0 (MMU-less fixups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.6.5.
A few additions and some fixes.

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.5-uc0.patch.gz

Change log:

. patch against 2.6.5                     me
. COBRA5272/5282 support                  Heiko Degenhardht
. fix m68knommu kernel_thread() return    me

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude          EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com






















