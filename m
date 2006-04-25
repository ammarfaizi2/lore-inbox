Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWDYAHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWDYAHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 20:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWDYAHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 20:07:45 -0400
Received: from mx21.sac.fedex.com ([199.81.218.126]:33478 "EHLO
	mx21.sac.fedex.com") by vger.kernel.org with ESMTP id S932138AbWDYAHo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 20:07:44 -0400
Date: Tue, 25 Apr 2006 08:07:32 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Pavel Machek <pavel@suse.cz>
cc: Jeff Chua <jeff.chua.linux@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       Chris Ball <cjb@mrao.cam.ac.uk>, Arkadiusz Miskiewicz <arekm@maven.pl>,
       Jeff Garzik <jeff@garzik.org>, Matt Mackall <mpm@selenic.com>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ... (fwd)
In-Reply-To: <20060424075511.GA26345@elf.ucw.cz>
Message-ID: <Pine.LNX.4.64.0604250806280.5533@boston.corp.fedex.com>
References: <Pine.LNX.4.64.0604232153230.2890@boston.corp.fedex.com>
 <20060424075511.GA26345@elf.ucw.cz>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 04/25/2006
 08:07:30 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 04/25/2006
 08:07:39 AM,
	Serialize complete at 04/25/2006 08:07:39 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Apr 2006, Pavel Machek wrote:

> Do suspend-to-disk, first. It is easier.
> You'll want to go with vanilla kernel.
> Disable SMP in kernel config, then; it makes perfect sense to test it
> UP.

Thanks for the very good suggestion. result ... success!

Jeff.
