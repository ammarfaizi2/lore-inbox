Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTGKOf5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbTGKOf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:35:56 -0400
Received: from mail.cybertrails.com ([162.42.150.35]:2573 "EHLO
	mail1.cybertrails.com") by vger.kernel.org with ESMTP
	id S262283AbTGKOfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:35:55 -0400
Date: Fri, 11 Jul 2003 07:50:31 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 'what to expect'
Message-Id: <20030711075031.425605cc.dickson@permanentmail.com>
In-Reply-To: <20030711140219.GB16433@suse.de>
References: <20030711140219.GB16433@suse.de>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003 15:02:19 +0100, Dave Jones wrote:

> Deprecated features.
> ~~~~~~~~~~~~~~~~~~~~
> - khttpd is gone.
> - Older Direct Rendering Manager (DRM) support (For XFree86 4.0)
>   has been removed. Upgrade to XFree86 4.1.0 or higher.
> - LVM1 has been removed. See Device-mapper below.
> - boot time root= parsing changed.
>   ramdisks are now ram<n> instead of rd<n> and cm206 is cm206cd (instead of
>   cm206).
> - The system call table is no longer exported. Any module that relied
>   on this previously will no longer work.
> - Soundmodem hamradio support has been removed. Its functionality
>   has been superceded by a userspace replacement.
>   http://www.baycom.org/~tom/ham/soundmodem
> - Direct booting from floppy is no longer supported.
>   You should now use a boot loader program instead.
> - Callout tty devices (/dev/cua) have been deprecated since 2.1.90pre2.
>   Support is now removed.

These are not deprecated, they are gone.  Deprecated means "in the process
of being phased out, but still usable".

	-Paul Dickson

