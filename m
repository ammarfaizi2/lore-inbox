Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270908AbTGQUo2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270920AbTGQUo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:44:27 -0400
Received: from law14-f43.law14.hotmail.com ([64.4.21.43]:43537 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270908AbTGQUo0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:44:26 -0400
X-Originating-IP: [24.114.155.74]
X-Originating-Email: [dbehman@hotmail.com]
From: "Dan Behman" <dbehman@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6: marking individual directories as synchronous?
Date: Thu, 17 Jul 2003 16:59:20 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law14-F4339RtMXxIGC0001edbb@hotmail.com>
X-OriginalArrivalTime: 17 Jul 2003 20:59:20.0835 (UTC) FILETIME=[4B506D30:01C34CA6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm reading through Joseph Pranevich's great document "Wonderful World of 
Linux 2.6" and I came across something that I'd love to learn more about.  
In the "Block Device Support" -> "Filesystems" section, reference is made to 
"Individual directories can now be marked as synchronous so that all changes 
(additional files, etc.) will be atomic".  I searched through the update 
info at kernelnewbies but
couldn't find any more information on this - could someone please elaborate 
on this?  What is it and how does it work?  Is there any design 
documentation for this?

Thanks!

Dan Behman...

_________________________________________________________________
MSN 8 with e-mail virus protection service: 2 months FREE*  
http://join.msn.com/?page=features/virus

