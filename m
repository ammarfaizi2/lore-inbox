Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129838AbQKAPpM>; Wed, 1 Nov 2000 10:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129508AbQKAPpC>; Wed, 1 Nov 2000 10:45:02 -0500
Received: from gatekeeper.trcinc.com ([208.224.120.226]:45049 "HELO gatekeeper")
	by vger.kernel.org with SMTP id <S131082AbQKAPoq>;
	Wed, 1 Nov 2000 10:44:46 -0500
Message-ID: <790BC7A85246D41195770000D11C56F21C847A@trc-tpaexc01.trcinc.com>
From: Jonathan George <Jonathan.George@trcinc.com>
To: "'matthew@mattshouse.com'" <matthew@mattshouse.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.0-test10 Sluggish After Load
Date: Wed, 1 Nov 2000 10:44:14 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt,

It might be helpful to show the current (post crippled) results of top.
Futhermore, a list of allocated ipc resources (share memory, etc.) and open
files (lsof) would be nice.

--Jonathan--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
