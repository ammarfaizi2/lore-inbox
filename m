Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUHAFYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUHAFYO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 01:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUHAFYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 01:24:14 -0400
Received: from bay17-f43.bay17.hotmail.com ([64.4.43.93]:27919 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265214AbUHAFYN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 01:24:13 -0400
X-Originating-IP: [199.203.24.239]
X-Originating-Email: [slifshitz@hotmail.com]
From: "shai lifshitz" <slifshitz@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: check_region question
Date: Sun, 01 Aug 2004 08:24:12 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY17-F431PAMiNAdAl00025bde@hotmail.com>
X-OriginalArrivalTime: 01 Aug 2004 05:24:12.0433 (UTC) FILETIME=[C77C7810:01C47787]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi group,

I try to grap the parallel port of a PC (x86), so as the first step I do: 
"check_region(0x378,3);"
the problem is that it fails.

anybody can tell me why, where can I check who took this memory, or where to 
it is mapped?

HELP

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE* 
http://join.msn.com/?page=features/junkmail

