Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318423AbSHBGad>; Fri, 2 Aug 2002 02:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318623AbSHBGad>; Fri, 2 Aug 2002 02:30:33 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:38384 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S318423AbSHBGac>; Fri, 2 Aug 2002 02:30:32 -0400
Message-ID: <3D4A27FE.8030801@snapgear.com>
Date: Fri, 02 Aug 2002 16:34:38 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.30uc0 MMU-less patches
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

I have a new set of uClinux (MMU-less) patches for 2.5.30 at:

   http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/

I have coded a generic MTD map driver to replace the old
crufty blkmem driver. The blkmem driver will be going away
in future patches.

Other than that it is still all working nicely.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com

