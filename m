Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbTDWM20 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 08:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264014AbTDWM20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 08:28:26 -0400
Received: from [61.11.16.46] ([61.11.16.46]:7694 "EHLO mailpune")
	by vger.kernel.org with ESMTP id S264012AbTDWM2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 08:28:25 -0400
Subject: Re: FileSystem Filter Driver
From: Abhishek Agrawal <abhishek@abhishek.agrawal.name>
To: Michael Knigge <Michael.Knigge@set-software.de>
Cc: Nir Livni <nir_l3@netvision.net.il>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030423.11473966@knigge.local.net>
References: <000501c30983$1ffb8950$ade1db3e@pinguin>
	 <1051092516.1896.7.camel@abhilinux.cygnet.co.in>
	 <20030423.11473966@knigge.local.net>
Content-Type: text/plain
Organization: 
Message-Id: <1051099862.2099.6.camel@abhilinux.cygnet.co.in>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4
Date: 23 Apr 2003 17:41:02 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 17:17, Michael Knigge wrote:


> Under Windows a pretty well-known filter driver is FileMon at
> www.sysinternals.com. Thex also have a Linux version but (ahhh)
> without Source (the source for the Windows-Version is available). The
> Linux-Version can be found at
> http://www.sysinternals.com/linux/utilities/filemon.shtml
>
> I guess what they are doing is similar to the way strace works - but
> I'm not sure. Hmmm, let us strace this thing ;-))))
>
Filemon look like it will not work with kernel 2.5 up.
>From the link...
"it replaces entries in the system call table with pointers to its own
hook functions."


