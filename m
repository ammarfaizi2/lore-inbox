Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVAUXfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVAUXfk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVAUXcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:32:12 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:25535 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262582AbVAUXW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:22:27 -0500
Message-ID: <41F18EAF.4000604@nortelnetworks.com>
Date: Fri, 21 Jan 2005 17:22:23 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: quick question on dmesg output
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is an edited output of dmesg, for a dual Xeon running 2.6.9:


Detected 1196.514 MHz processor.
<snip>
Calibrating delay loop... 2383.87 BogoMIPS (lpj=1191936)
<snip>
CPU1: Intel(R) Xeon(TM) CPU 2.00GHz stepping 09



I'm a bit confused why a 2GHz chip gets detected as a 1.2 GHz cpu.  Is 
this something strange in my hardware?

Chris
