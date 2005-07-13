Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVGMMYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVGMMYO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 08:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVGMMYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 08:24:14 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:21961 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262581AbVGMMXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 08:23:07 -0400
Date: Wed, 13 Jul 2005 17:52:57 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Current kexec status?
Message-ID: <20050713122257.GA29477@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20050713104848.GJ4561@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713104848.GJ4561@charite.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 12:48:49PM +0200, Ralf Hildebrandt wrote:
> I want to experiment with kexec and my 2.6.13-rc3 kernel. I'm able to
> --load the kernel, but on --exec in /etc/init.d/reboot (I replaced the
> reboot command in there), the machine freezes.

Can you give more details like
- Which distro release you are running.
- Exactly what changes did you do to /etc/init.d/reboot and what steps
did you follow to load the kernel (command line options).
- What do you see on screen? Did the new kernel start booting at all.
- Would be nice if I can get serial console output.

> 
> I'm using kexec-tools-1.101, are there any more patches needed?
> 

For normal kexec, no. You don't need any more patches.

Thanks
Vivek

