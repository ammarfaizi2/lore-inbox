Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUASNRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 08:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUASNRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 08:17:22 -0500
Received: from gizmo08bw.bigpond.com ([144.140.70.18]:28381 "HELO
	gizmo08bw.bigpond.com") by vger.kernel.org with SMTP
	id S264916AbUASNRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 08:17:19 -0500
Message-ID: <400BD910.2000608@snapgear.com>
Date: Mon, 19 Jan 2004 23:18:08 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.6.1-uc0 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

An update of the uClinux (MMU-less) fixups against linux-2.6.1.
Quite a few small fixes here, mostly carried forward from previous
patch sets. One important new fix to the page_alloc code for MMUless
systems.

You can get it at:

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.1-uc0.patch.gz

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
Snapgear - A CyberGuard Company             PHONE:       +61 7 3279 1822
825 Stanley St,                             FAX:         +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
































