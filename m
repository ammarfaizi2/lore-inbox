Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932705AbVKBNUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbVKBNUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbVKBNUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:20:34 -0500
Received: from agmk.net ([217.73.31.34]:64013 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S932705AbVKBNUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:20:33 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [2.6.14-rt1] slowdown / oops.
Date: Wed, 2 Nov 2005 14:20:27 +0100
User-Agent: KMail/1.8.3
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511021420.28104.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

With patch-2.6.14-rt1 I notice below problems:

1).
I'm observing a major system slowdown after several hours of uptime.
This is a normal workstation (running kde, gcc, etc.).
Once I got on all open terminals an error message:
`VFS: file-max limit 51078 reached` and it freezed.

2).
During `scp bigfile to another machine` I get an oops:
http://149.156.124.14/~pluto/tmp/2.6.14-rt2-oops.jpg [796 kB]

Any ideas?

Reagrds,
Paweł.

-- 
The only thing necessary for the triumph of evil
  is for good men to do nothing.
                                           - Edmund Burke
