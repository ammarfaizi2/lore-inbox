Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267294AbUIWOye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUIWOye (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 10:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUIWOyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 10:54:31 -0400
Received: from relay-1m.club-internet.fr ([194.158.104.40]:8132 "EHLO
	relay-1m.club-internet.fr") by vger.kernel.org with ESMTP
	id S266896AbUIWOy2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 10:54:28 -0400
From: pinotj@club-internet.fr
To: linux-kernel@vger.kernel.org
Subject: Patched nVidia drivers for kernel > 2.6.9-rc2-bk3
Date: Thu, 23 Sep 2004 16:54:26 CEST
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1095951266.963.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I posted on my blog a patched version of the nVidia Linux display driver (6111) for kernel > 2.6.9-rc2-bk3. The vanilla one can not compile against current kernel because of the change in the mm (vmalloc and the new __VMALLOC_RESERVE symbol).

I don't know if the patch is clean enough but it works flawless for me, so I think it could help.

Here is the post:
http://ngc891.blogdns.net/index.php?2004/09/21/3-patched-nvidia-drivers
 

Regards,

--
Jerome Pinot
http://ngc891.blogdns.net
http://cercle-daejeon.homelinux.org/linux


