Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTJVMbk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 08:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263527AbTJVMbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 08:31:40 -0400
Received: from mailgate.imerge.co.uk ([195.217.208.100]:8464 "EHLO
	imgserv04.imerge-bh.co.uk") by vger.kernel.org with ESMTP
	id S263448AbTJVMbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 08:31:39 -0400
Message-ID: <C0D45ABB3F45D5118BBC00508BC292DB016038FE@imgserv04>
From: James Finnie <jf1@IMERGE.co.uk>
To: "'James Courtier-Dutton'" <James@superbug.demon.co.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: VIA IDE performance under 2.6.0-test7/8?
Date: Wed, 22 Oct 2003 13:31:49 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just turn on SMB support in the "make menuconf", and it should enable 
> IO-APIC.

As I thought, on these VIA EPIA-M boards there is no IO-APIC, so enabling
the option in the kernel config makes no difference.  Cheers for the idea
tho.

James.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
Imerge Limited                          Tel :- +44 (0)1954 783600 
Unit 6 Bar Hill Business Park           Fax :- +44 (0)1954 783601 
Saxon Way                               Web :- http://www.imerge.co.uk 
Bar Hill 
Cambridge 
CB3 8SL 
United Kingdom 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


