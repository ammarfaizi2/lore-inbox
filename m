Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUGCMyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUGCMyL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 08:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbUGCMyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 08:54:10 -0400
Received: from bay16-f33.bay16.hotmail.com ([65.54.186.83]:40719 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265086AbUGCMyB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 08:54:01 -0400
X-Originating-IP: [220.224.15.176]
X-Originating-Email: [kartik_me@hotmail.com]
From: "kartikey bhatt" <kartik_me@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: two questions
Date: Sat, 03 Jul 2004 18:23:58 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY16-F33zN3arTZiqp000060ee@hotmail.com>
X-OriginalArrivalTime: 03 Jul 2004 12:53:58.0339 (UTC) FILETIME=[CE5C3130:01C460FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have two questions if anyone can help me out?

(1) in bsd when a socket is created, the process
creating the socket is passed as a structure
to so_create call. in linux how can we have
this mechanism by which when a socket is created
we can access the task_t of the process creating the
socket?

(2) given the sk_buff* how to lookup the associated
socket?

please help me out.

--kartikey

_________________________________________________________________
Get FREE unlimited Citibank ATM transactions! 
http://go.msnserver.com/IN/52040.asp Discover real-value banking here.

