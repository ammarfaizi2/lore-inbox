Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVFMPvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVFMPvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVFMPvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:51:04 -0400
Received: from alog0263.analogic.com ([208.224.222.39]:23780 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261605AbVFMPui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:50:38 -0400
Date: Mon, 13 Jun 2005 11:50:34 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Pausing a task
Message-ID: <Pine.LNX.4.61.0506131142120.17826@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How can I (as root) pause or suspend a process?
On VAX/VMS one could do `set process=suspend`. This
would allow the system manager to check on a possibly
rogue user.

Let's say that "Hacker Jack" just got fired because
he was disrupting a project. One needs to find any of
his processes where he might be deleting a project
tree. Pausing, rather than killing the tasks would
allow evidence to be gathered. Basically, I need
to set the task(s) priorities to something that
will take them out of the run-queue altogether.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
