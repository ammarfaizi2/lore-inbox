Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263954AbTHWWCp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 18:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264005AbTHWWCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 18:02:45 -0400
Received: from 217-124-31-55.dialup.nuria.telefonica-data.net ([217.124.31.55]:34432
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S263954AbTHWWCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 18:02:43 -0400
Date: Sun, 24 Aug 2003 00:02:40 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.0-test4: "rmmod floppy" _still_ hangs the box
Message-ID: <20030823220240.GA1165@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030810141512.GB421@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810141512.GB421@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 10 August 2003, at 16:15:12 +0200,
Jose Luis Domingo Lopez wrote:

> [1.] One line summary of the problem:    
> "rmmod floppy" hangs the box if done shortly after "modprobe floppy" and
> no floppy in the drive
> 
Exactly the same test case previously reported, with the same nasty
results, but now for kernel version 2.6.0-test4.

Hope this helps.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test4)
