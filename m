Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVALV3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVALV3B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVALVZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:25:37 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:40878 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261389AbVALVWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:22:00 -0500
Message-ID: <41E595E9.8040805@sbcglobal.net>
Date: Wed, 12 Jan 2005 13:26:01 -0800
From: Steve <s.egbert@sbcglobal.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050109)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.10-r1 MTRR bug
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the Athlon 2100, I get the following outputs and then the VGA 
console is frozen from further output (but it doesn't prevent the full 
bootup into X windows session of which I am able to resume normal 
Linux/X session, but not able to regain any virtual console session.)

The virtual console (locked) shows the following outputs:

vesafb: scrolling: redraw:
mtrr: size and base must be multiples of 4kiB  (<<-- this line is 
repeated 20 times).



