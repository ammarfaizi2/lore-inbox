Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265767AbUFINIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265767AbUFINIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265749AbUFINIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:08:15 -0400
Received: from main.gmane.org ([80.91.224.249]:1246 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265767AbUFINHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:07:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nirendra Awasthi <linux@nirendra.net>
Subject: Reading struct_task in user space
Date: Wed, 09 Jun 2004 18:36:39 +0530
Message-ID: <ca721p$o67$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 61.16.153.178
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  How can I read struct_task (defined in linux/sched.h) in user space, 
in order to determine if PF_DUMPCORE flag is set for the process and it 
is having core dump.

-Nirendra

