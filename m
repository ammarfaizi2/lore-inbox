Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVEQXn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVEQXn1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 19:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVEQXls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:41:48 -0400
Received: from smtp007.bizmail.sc5.yahoo.com ([66.163.170.10]:35427 "HELO
	smtp007.bizmail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261748AbVEQXha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:37:30 -0400
Message-ID: <428A8034.801@metricsystems.com>
Date: Tue, 17 May 2005 16:37:24 -0700
From: John Clark <jclark@metricsystems.com>
Organization: Metric Systems, Inc.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: GDB, pthreads, and kernel threads
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of my work has been in the kernel and I had not paid attention to
user 'threads'. However, I have at the moment to a need to debug a
user 'pthread' based applicaiton, that I may want to move into the kernel.

However, I can't seem to figure out how to get GDB to debug my user
pthreads app. What is the correct setup to debug pthreads based applications
now that it seems that pthreads implementation generates processes/threads
in the kernel.

Thanks
John Clark

