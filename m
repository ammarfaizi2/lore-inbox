Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTJYUFu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 16:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTJYUFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 16:05:50 -0400
Received: from morbo.e-centre.net ([66.154.82.3]:28104 "EHLO
	morbo.e-centre.net") by vger.kernel.org with ESMTP id S262888AbTJYUFm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 16:05:42 -0400
Date: Sat, 25 Oct 2003 16:05:25 -0400
From: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Announce: Swsusp-2.0-2.6-alpha1
Message-ID: <20031025200524.GA1170@iain-vaio-fx405>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1067069558.1975.54.camel@laptop-linux> <20031025192019.GA1033@iain-vaio-fx405>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025192019.GA1033@iain-vaio-fx405>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Linux/2.6.0-test8 (i686)
X-Uptime: 15:58:36 up 15 min,  3 users,  load average: 0.38, 0.19, 0.12
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* iain d broadfoot (ibroadfo@cis.strath.ac.uk) wrote:
> * Nigel Cunningham (ncunningham@clear.net.nz) wrote:
> > Hi all.
> > 
> > I'm pleased to be able to announce the first test release of a port of
> > the current 2.0 pre-release Software Suspend code to 2.6. 
> 
> hurrah!
> 
> The attached patch allowed the kernel to compile for me, haven't booted
> into it as yet.

when trying to suspend (either by directly echoing > /proc/swsusp/activate,
or with the script) It only gets as far as the first screen "killing
processes/freeing space" (can't remember the exact message despite
staring at it for a good 20 mins total today)

the 'r' and 'l' keys both change the message, toggling reboot and
logging respectively, but no other keys have any effect.

cheers,
iain

-- 
"If sharing a thing in no way diminishes it, it is not rightly owned if it is
not shared." -- St. Augustine
