Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSIPHLD>; Mon, 16 Sep 2002 03:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSIPHLD>; Mon, 16 Sep 2002 03:11:03 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:64242 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S315988AbSIPHLB>; Mon, 16 Sep 2002 03:11:01 -0400
Message-ID: <3D85854E.7060401@snapgear.com>
Date: Mon, 16 Sep 2002 17:16:30 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.35uc0 (MMU-less support)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

Updated patch for MMU-less CPU support uClinux-2.5.35uc0.patch.gz
is at:

   http://www.uclinux.org/pub/uClinux/uClinux-2.5.x

I am thinking about breaking this up into a few separate
patches as well. Logically there is a parts that fit
together separately (new ethernet driver, new fb, etc).
I'll try and get that out soon...

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

