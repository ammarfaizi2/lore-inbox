Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319088AbSH2C2U>; Wed, 28 Aug 2002 22:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319090AbSH2C2T>; Wed, 28 Aug 2002 22:28:19 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:51439 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S319088AbSH2C2S>; Wed, 28 Aug 2002 22:28:18 -0400
Message-ID: <3D6D880B.8090401@snapgear.com>
Date: Thu, 29 Aug 2002 12:33:47 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.32uc1 (MMU-less patches)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

A new MMU-less patch, linux-2.5.32uc1. You can get it at:

   http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/

A few minor fixes:

. Fixed incorrect setting of totalram_pages in arch mm init
. Added some vmalloc_ routines to fix module support
. Added m68knommu config support for security and lib sub-systems
. Added Config.help to arch/m68knommu

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

