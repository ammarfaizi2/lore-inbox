Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVDODSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVDODSI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 23:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVDODSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 23:18:08 -0400
Received: from mail.avantwave.com ([210.17.210.210]:1475 "EHLO
	mail.avantwave.com") by vger.kernel.org with ESMTP id S261727AbVDODSF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 23:18:05 -0400
Message-ID: <425F3265.1080508@haha.com>
Date: Fri, 15 Apr 2005 11:17:57 +0800
From: Tomko <tomko@haha.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question about returning of a child process
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

What is  the first code the new born child process run after it is 
forked by the system call and being schduled into the CPU to run ? what 
i concerned is , kernel will schdule once when leaving the system call 
for returning father process, will kernel schdule once again when 
leaving the systemcall for child process if the child process return 
code is inside the kernel space?

Hope someone can answer me.

TOM
