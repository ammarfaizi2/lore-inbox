Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268018AbUHEXxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268018AbUHEXxE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 19:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268021AbUHEXxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 19:53:04 -0400
Received: from mta2.rdslink.ro ([193.231.236.124]:33977 "EHLO mta2.rdslink.ro")
	by vger.kernel.org with ESMTP id S268018AbUHEXxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 19:53:01 -0400
Date: Fri, 6 Aug 2004 01:11:06 +0300 (EEST)
From: caszonyi@rdslink.ro
X-X-Sender: sony@grinch.ro
Reply-To: Calin Szonyi <caszonyi@rdslink.ro>
To: "Brown, Len" <len.brown@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: 2.6.7-mm[3-4] doesn't boot (alsa or pnp related) (fixed - Acpi)
In-Reply-To: <29AC424F54821A4FB5D7CBE081922E400124DA23@hdsmsx403.hd.intel.com>
Message-ID: <Pine.LNX.4.53.0408060109200.334@grinch.ro>
References: <29AC424F54821A4FB5D7CBE081922E400124DA23@hdsmsx403.hd.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2004, Brown, Len wrote:

> can I trouble you to open a bugzilla entry for this one?
> with OLS I'm hopelessly behind in e-mail and that
> is the only way I'll be able to focus on this issue.
>
> I need the info from the last kernel with acpi enabled
> that worked; and the info from the new kernel where
> it doesn't work.
>
> Also, it might be a good idea to try the latest mm patch
> coming out next week, or the latest acpi patch against
> the base tree, which is here today:
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/
>
> thanks
> -Len
>

FYI 2.6.8-rc3 works ok.

Thanks
Calin

--
"A mouse is a device used to point at
the xterm you want to type in".
Kim Alm on a.s.r.
