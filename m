Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270804AbTGPJPR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 05:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270805AbTGPJPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 05:15:17 -0400
Received: from tazz.wtf.dk ([80.199.6.58]:38016 "EHLO sokrates")
	by vger.kernel.org with ESMTP id S270804AbTGPJPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 05:15:15 -0400
Date: Wed, 16 Jul 2003 11:30:37 +0200
From: Michael Kristensen <michael@wtf.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Unable to boot linux-2.6-test1
Message-ID: <20030716093037.GA1686@sokrates>
References: <200307160904.08524.christian@borntraeger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200307160904.08524.christian@borntraeger.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Bornträger <christian@borntraeger.net> [2003-07-16 10:34:13]:
> No, you have not.
> from your first mail:
> 
>   module-init-tools      2.4.21
> 
> This version belongs to modutils.

Yes, that was back then :-) Later, after I installed the Debian package
module-init-tools, everything worked fine. I only thought the package
was needed to *load* the modules, not create them. So, everything works
now. Thanks to everyone who answered to this thread and of course to the
Linux kernel team for creating, maintaining and developing the kernel
:-)

-- 
Med Venlig Hilsen/Best Regards/Mit freundlichen Grüßen
Michael Kristensen <michael@wtf.dk>
