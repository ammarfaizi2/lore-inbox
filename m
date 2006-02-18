Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWBRWR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWBRWR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 17:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWBRWR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 17:17:28 -0500
Received: from bay104-f18.bay104.hotmail.com ([65.54.175.28]:28297 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932209AbWBRWR1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 17:17:27 -0500
Message-ID: <BAY104-F1839F2D6FF3DAC247F1677C0F90@phx.gbl>
X-Originating-IP: [137.207.140.83]
X-Originating-Email: [kamrankarimi@hotmail.com]
In-Reply-To: <36BEEFA2DF192944BF71E072F7A5F465228B92@xchange1.phage.bcgsc.ca>
From: "Kamran Karimi" <kamrankarimi@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: DIPC alpha3 for 2.6.x kernels: Now works on a single computer
Date: Sat, 18 Feb 2006 16:17:26 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 18 Feb 2006 22:17:26.0821 (UTC) FILETIME=[19926550:01C634D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

DIPC (Distributed IPC) is a system software that provides distributed access
to messages, semaphores, and shared memory segments. It can be used to
transparently exchange data between distributed applications.

As another step in porting DIPC to Linux 2.6.x, the example programmes in 
2.1-alpha3 version of DIPC now work on a single machine (they haven't been 
tried over a network). Please let me know of your experience if you 
installed and tested DIPC, especially in a distributed environment.

You can download this version of DIPC from: 
http://cs.uwindsor.ca/~kamran/downloads.html

-Kamran


