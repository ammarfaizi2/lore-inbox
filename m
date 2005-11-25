Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVKYLxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVKYLxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 06:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVKYLxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 06:53:52 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:25606 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932201AbVKYLxv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 06:53:51 -0500
To: Rob Landley <rob@landley.net>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: pivot_root broken in 2.6.15-rc1-mm2
References: <17283.52960.913712.454816@cse.unsw.edu.au>
	<200511230543.24353.rob@landley.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: if it payed rent for disk space, you'd be rich.
Date: Fri, 25 Nov 2005 11:53:42 +0000
In-Reply-To: <200511230543.24353.rob@landley.net> (Rob Landley's message of
 "23 Nov 2005 11:44:59 -0000")
Message-ID: <87lkzdkkop.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Nov 2005, Rob Landley said:
> I wrote Documentation/filesystems/ramfs-rootfs-initramfs.txt just for this 
> occasion. :)

And very damn helpful it was, too; thank you. I didn't really grasp
the fundamental difference between initramfs and initrd until now: I
thought it was just a matter of storage location (cpio-in-kernel versus
image-in-separate-file)...

-- 
`Y'know, London's nice at this time of year. If you like your cities
 freezing cold and full of surly gits.' --- David Damerell

