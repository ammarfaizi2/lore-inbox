Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbUEJXo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUEJXo7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUEJXo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:44:58 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:48645 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S262079AbUEJXjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:39:54 -0400
Message-ID: <40A012A4.7060703@snapgear.com>
Date: Tue, 11 May 2004 09:39:16 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.6-uc0 (MMU-less fixups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.6.6.
A lot of things merged in 2.6.6, so only a handful of patches
for general uClinux and m68knommu.

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.6-uc0.patch.gz

Change log:

. integrate armnommu support                   Hyok S. Choi
. add find_next_bit() to m68knommu bitops.h    me
. merge with linux-2.6.6                       me

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude          EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com






















