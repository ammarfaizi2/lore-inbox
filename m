Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268235AbUHXT2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268235AbUHXT2q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268239AbUHXT2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:28:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:33747 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268235AbUHXT2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:28:23 -0400
X-Authenticated: #494916
Message-ID: <412B96EF.3060900@gmx.de>
Date: Tue, 24 Aug 2004 21:28:47 +0200
From: Peter Schaefer <peter.schaefer@gmx.de>
Reply-To: peter.schaefer@gmx.de
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OT] SCSI command filter: Add cdparanoia to the list
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Following the discus^H^H^H flamewar about cdrecord, scsi command
filter et al, i just want to add that ripping audio CDs seems
to be affected by the SCSI filter also. I'm not able to use
my SCSI CDRW drive for that anymore (except being root) and
have to resort to my (ATAPI) DVD drive.

Setting cdparanoia suid root works, however for grip that's
no solution b/c GTK+ applications don't want to be suid
root.

Just my 2c. Please keep that in mind.

Thanks and best regards,

  Peter

-- 
NOTE: I'm NOT subscribed, please CC me on replies.

