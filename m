Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUBEBsC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 20:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbUBEBsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 20:48:01 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:30226 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S264238AbUBEBr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 20:47:57 -0500
Message-ID: <4021A111.1070807@snapgear.com>
Date: Thu, 05 Feb 2004 11:49:05 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.2-uc0 (MMU-less fixups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.6.2.
A few new things, and some previous patches now merged.

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.2-uc0.patch.gz

New in this patch:

. mcfserial tiocmget/set fixup     Russell King
. mcfserial cleanup                Randy Dunlap/Domen Puncer
. remove unused CONFIG_LEDMAN      Randy Dunlap/Domen Puncer
. 68328 frame buffer fixups        Georges Menie
. m68k support for cs89x00         Georges Menie

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude          EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com




















