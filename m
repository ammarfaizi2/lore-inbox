Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbULIKbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbULIKbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 05:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbULIKbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 05:31:24 -0500
Received: from bay22-f28.bay22.hotmail.com ([64.4.16.78]:12526 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261496AbULIKbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 05:31:10 -0500
Message-ID: <BAY22-F28AE168E3AE8DE897DB2A6AAB70@phx.gbl>
X-Originating-IP: [212.143.127.195]
X-Originating-Email: [zstingx@hotmail.com]
From: "sting sting" <zstingx@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: make tags in linux kernel (2.6.7)
Date: Thu, 09 Dec 2004 12:30:13 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 09 Dec 2004 10:31:07.0391 (UTC) FILETIME=[315B90F0:01C4DDDA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  I ran make tags in 2.6.7 to create a tags file on 2.6.7 kernel source 
tree.

	The tags mechanism works OK for me with this tag file,
	except in one subfolder , which is fs (and all it's subfolder).

	This means that when I try "follow tags" in a file under fs or
	one of it's subdir, not a sinlge possibility is showed.

	(I use jedit tags plugin ).

	I would like to know if anyone using "make tags" on this version/other 
versions
	had encounterd such problems.
	regards,
Sting

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

