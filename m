Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263752AbUECPeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUECPeN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 11:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263750AbUECPeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 11:34:12 -0400
Received: from main.gmane.org ([80.91.224.249]:47285 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263748AbUECPeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 11:34:10 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: Bad data in microcode data file message with linux 2.4.25.
Date: Mon, 03 May 2004 09:34:06 -0600
Message-ID: <c75opf$v2d$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cynosure.colorado-research.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone explain these please?

May  2 10:58:34 saga kernel: microcode: collect_cpu_info : sig=0xf27, 
pf=0x2, rev=0x34
May  2 10:58:34 saga kernel: microcode: collect_cpu_info : sig=0xf27, 
pf=0x2, rev=0x34
May  2 10:58:34 saga kernel: microcode: error! Bad data in microcode 
data file
May  2 10:58:34 saga kernel: microcode: Error in the microcode data

System is an FC1 box running a fairly stock 2.4.25 kernel.

Thanks!

