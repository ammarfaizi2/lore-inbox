Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272651AbTG3DGK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 23:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272716AbTG3DGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 23:06:10 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:33293 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S272651AbTG3DGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 23:06:05 -0400
Message-ID: <3F273624.8020807@snapgear.com>
Date: Wed, 30 Jul 2003 13:06:12 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.0-test2-uc0 (MMU-less fixups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

An update of the uClinux (MMU-less) fixups against 2.6.0-test2.
Only a few small changes over linux-2.6.0-test1-uc0. You can get
the patch at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.6.0-test2-uc0.patch.gz


Changelog:

. import/merge with linux-2.6.0-test2             me
. partial baud rate support (5272)                Bernardo Innocenti


Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude          EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com












