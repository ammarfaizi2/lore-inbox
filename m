Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbTDNU41 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263767AbTDNU41 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:56:27 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:4105 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263769AbTDNU40 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 16:56:26 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: 2.5 'what to expect' document.
Date: Mon, 14 Apr 2003 23:08:03 +0200
User-Agent: KMail/1.5
References: <20030414193138.GA24870@suse.de>
In-Reply-To: <20030414193138.GA24870@suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304142308.03553.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 April 2003 21:31, Dave Jones wrote:
> Extra tainting.
> ~~~~~~~~~~~~~~~
> Running certain AMD processors in SMP boxes is out of spec, and will taint
> the kernel with the 'S' flag.  Running 2 Athlon XPs for example may seem to
> work fine, but may also introduce difficult to pin down bugs.
> In time it's likely this tainting will be extended to cover other out of
> spec cases.

Will it be implemented in future to taint the kernel if CPU is overclocked?

-- 
Regards Michael Buesch.
http://www.8ung.at/tuxsoft

$ cat /dev/zero > /dev/null
/dev/null: That's *not* funny! :(

