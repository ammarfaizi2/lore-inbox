Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbTDEL7C (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 06:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTDEL7C (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 06:59:02 -0500
Received: from comtv.ru ([217.10.32.4]:39409 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id S262134AbTDEL7B (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 06:59:01 -0500
X-Comment-To: "Sean Hunter"
To: "Sean Hunter" <sean@uncarved.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops every write with ext3 + sync + data=journal
References: <20030405073525.GC2806@uncarved.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 05 Apr 2003 15:00:35 +0400
In-Reply-To: <20030405073525.GC2806@uncarved.com>
Message-ID: <m3wui96wfg.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Sean Hunter (SH) writes:

 SH> Hi there
 SH> I got the 2.5 series functional here for the first time by changing the
 SH> mount options on one of my filesystems.  It would crash everytime syslog
 SH> tried to write to /var, which was mounted
 SH> rw,sync,data=journal,nosuid,nodev

 SH> I changed it to rw,nosuid,nodev and the box is now happy.  I'll change
 SH> it back sometime to capture the oops if someone cares.

show the oops message, please

