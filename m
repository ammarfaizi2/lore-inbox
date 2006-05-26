Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWEZTES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWEZTES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 15:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWEZTES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 15:04:18 -0400
Received: from mail1.utc.com ([192.249.46.190]:44451 "EHLO mail1.utc.com")
	by vger.kernel.org with ESMTP id S1751283AbWEZTER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 15:04:17 -0400
Message-ID: <44775129.6030004@cybsft.com>
Date: Fri, 26 May 2006 14:04:09 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.16-rt24 Won't Apply
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

The 2.6.16-rt24 patch that you uploaded today will not apply cleanly to
a 2.6.16 source tree. Below is the first of many problems, if this helps.

patching file Documentation/DocBook/Makefile
patching file Documentation/RCU/whatisRCU.txt
patching file Documentation/feature-removal-schedule.txt
patching file Documentation/kernel-parameters.txt
can't find file to patch at input line 96
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|Index: linux/Documentation/robust-futexes.txt
|===================================================================
|--- linux.orig/Documentation/robust-futexes.txt
|+++ linux/Documentation/robust-futexes.txt
--------------------------
File to patch:

-- 
   kr
