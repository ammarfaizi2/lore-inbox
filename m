Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUCPU3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 15:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbUCPU3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 15:29:04 -0500
Received: from imap.gmx.net ([213.165.64.20]:12729 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261638AbUCPU3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 15:29:00 -0500
Date: Tue, 16 Mar 2004 21:28:54 +0100 (MET)
From: =?ISO-8859-1?Q?=22Fabian_LoneStar_Fr=E9d=E9rick=22?= 
	<fabian.frederick@gmx.fr>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [2.6.4] vmregress alloc freeze
X-Priority: 3 (Normal)
X-Authenticated: #9223398
Message-ID: <22410.1079468934@www9.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

     When testing vmregress against 2.6.4, I get my term freezed when doing
echo 1000 > /proc/vmregress/test_alloc_low for instance....Someone could
explain that behaviour ?
(AFAICS, any value > 500 on alloc_fast & low will fail).

PS : I watch free parallely and alloc/free seems to work perfectly indeed...

Regards,
Fabian

-- 
+++ NEU bei GMX und erstmalig in Deutschland: TÜV-geprüfter Virenschutz +++
100% Virenerkennung nach Wildlist. Infos: http://www.gmx.net/virenschutz

