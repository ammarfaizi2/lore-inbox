Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbTHUNos (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 09:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbTHUNnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 09:43:46 -0400
Received: from law14-f73.law14.hotmail.com ([64.4.21.73]:25875 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262679AbTHUNIU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 09:08:20 -0400
X-Originating-IP: [194.85.81.178]
X-Originating-Email: [john_r_newbie@hotmail.com]
From: "John Newbie" <john_r_newbie@hotmail.com>
To: sneakums@zork.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maybe remove request_module("scsi_hostadapter"); from ->
Date: Thu, 21 Aug 2003 17:08:19 +0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law14-F73UTyiSw5CFc00071a4b@hotmail.com>
X-OriginalArrivalTime: 21 Aug 2003 13:08:20.0136 (UTC) FILETIME=[4B153A80:01C367E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>There already exists a solution, which is to alias scsi_hostadapter to
>off.

Ok, I have IDE box with scsi built in (not module), many people have such 
boxes,
I have alias scsi_hostadapter off, and I _have_ this annoying pseudo-error 
message.
(As I've said scsi starts before we can access modules.conf)

My solution is better. It is tested. Works perfect. All happy.
Please apply.

_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

