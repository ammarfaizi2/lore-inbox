Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWGUSdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWGUSdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 14:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWGUSdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 14:33:21 -0400
Received: from main.gmane.org ([80.91.229.2]:42196 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751103AbWGUSdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 14:33:20 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-2?q?=A3ukasz_Jachymczyk?= <lfx@tlen.pl>
Subject: RE:  BUG? rebooting
Date: Fri, 21 Jul 2006 20:33:33 +0200
Message-ID: <pan.2006.07.21.18.33.27.750041@tlen.pl>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1120717@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: afh66.internetdsl.tpnet.pl
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Fri, 21 Jul 2006 23:33:08 +0800, Yu, Luming napisa³(a):

> please take a look at bugziila.kernel.org
> please try http://bugzilla.kernel.org/show_bug.cgi?id=6814
> then try http://bugzilla.kernel.org/show_bug.cgi?id=6655

Thanks, but it doesn't work. I tried this reboot patch - nothing changed.
Also grepping in dmesg searching "machine_reset" after applying debug
patch gave no results.
This bug is about acpi, but as I said my problem exists even when I
compile kernel without acpi. Maybe I should post my own bug on bugzilla? 
I don't have any idea what to check next. 

-- 
£ukasz Jachymczyk
http://fatcat.ftj.agh.edu.pl/~lfx/


