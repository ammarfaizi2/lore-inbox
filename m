Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266230AbUALSDX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 13:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266229AbUALSDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 13:03:22 -0500
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:53888
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP id S266230AbUALSDJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 13:03:09 -0500
Message-ID: <20040112180307.3626.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-0.27
To: linux-kernel@vger.kernel.org
cc: dag@newtech.fi
Subject: Added disk activity from 2.6.0 to 2.6.1
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Mon, 12 Jan 2004 20:03:07 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

some days ago I installed 2.6.1 here and immediately
noticed a slower bootup time.
The disk during boot is also very much  showing a lot more
activity.
And the same when starting up a new program.
Was there a change that explains this?

I just reinstalled 2.6.0 and everything went back to being
quite peaceful.

My configuration:
- 2 x 500MHz P-III
- NCR 53c875 SCSI controller
- Preemption enabled
- 512 MB memory

BRGDS


-- 
Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Träsktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


