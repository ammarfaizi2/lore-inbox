Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262769AbUKXStX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbUKXStX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 13:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbUKXSsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 13:48:21 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:46224 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S262775AbUKXSle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 13:41:34 -0500
Message-ID: <41A4D5A4.3010605@blue-labs.org>
Date: Wed, 24 Nov 2004 13:40:36 -0500
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.10-rc2 and x86_64; spontaneous reboots
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone else experiencing spontaneous reboots within a few minutes of 
bootup?  (If the system survives past the first 10 minutes, it stays up 
for a long time, but it reliably does an instant reboot with no panic or 
other indication a good 9 out of 10 times.  The system is purely idle, 
nothing going on.  memtest86+ runs for hours with no failures.

David
