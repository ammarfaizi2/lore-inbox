Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTDEUyt (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 15:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbTDEUyt (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 15:54:49 -0500
Received: from userk185.dsl.pipex.com ([62.188.58.185]:9857 "HELO
	userk185.dsl.pipex.com") by vger.kernel.org with SMTP
	id S262657AbTDEUys (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 15:54:48 -0500
From: "Sean Hunter" <sean@uncarved.com>
Date: Sat, 5 Apr 2003 21:06:19 +0000
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops every write with ext3 + sync + data=journal
Message-ID: <20030405210619.GA2224@uncarved.com>
Mail-Followup-To: Sean Hunter <sean@uncarved.com>,
	Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org
References: <20030405073525.GC2806@uncarved.com> <m3wui96wfg.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3wui96wfg.fsf@lexa.home.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 03:00:35PM +0400, Alex Tomas wrote:
> >>>>> Sean Hunter (SH) writes:
> 
>  SH> Hi there
>  SH> I got the 2.5 series functional here for the first time by changing the
>  SH> mount options on one of my filesystems.  It would crash everytime syslog
>  SH> tried to write to /var, which was mounted
>  SH> rw,sync,data=journal,nosuid,nodev
> 
>  SH> I changed it to rw,nosuid,nodev and the box is now happy.  I'll change
>  SH> it back sometime to capture the oops if someone cares.
> 
> show the oops message, please

I'll try to get it for you but the machine in question is very busy for
the rest of the weekend and is a mail and dns sever normally so any
outage is not that good.  I had a small window this morning and last
night to get it working.

Sean
