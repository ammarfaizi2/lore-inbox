Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTKYPJb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 10:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTKYPJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 10:09:31 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:10886 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262709AbTKYPJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 10:09:30 -0500
Date: Tue, 25 Nov 2003 10:00:25 -0500
From: Ben Collins <bcollins@debian.org>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: data from kernel.bkbits.net
Message-ID: <20031125150025.GT1090@phunnypharm.org>
References: <20031124051910.GA2766@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031124051910.GA2766@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 23, 2003 at 09:19:10PM -0800, Larry McVoy wrote:
> 
> I've been trying to get all the data off the drives on the machine which
> was broken into.  I have a feeling that whoever this was was hiding stuff
> in the file system because both drives will not fsck clean nor will they
> completely read.
> 
> I've managed to get most of the data off but not all.  Given that I've put
> about 3 days into this I'm pretty much done.  If someone else wants to look
> at the drives I can make them available, let me know.  But just reading the
> main drive makes the kernel (Fedora 1) kill the tar process as below (it
> also managed to wack the system enough that it overwrote the NVRAM with
> garbage).  It hasn't been a fun weekend.

FYI, you can ignore the large SVN repos. They are easily rebuilt. I just
need the bkcvs2svn script in my home directory.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
