Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbTILJdF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 05:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTILJdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 05:33:05 -0400
Received: from luli.rootdir.de ([213.133.108.222]:15296 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S261362AbTILJdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 05:33:02 -0400
Date: Fri, 12 Sep 2003 11:32:53 +0200
From: Claas Langbehn <claas@rootdir.de>
To: Harry Brueckner <hb@o-d.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs with 2.6.0-test4 kernel
Message-ID: <20030912093253.GA3323@rootdir.de>
References: <196810000.1063269840@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <196810000.1063269840@localhost.localdomain>
Reply-By: Mo Sep 15 11:31:17 CEST 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test5-mm1 i686
X-No-archive: yes
X-Uptime: 11:31:17 up 6 min,  2 users,  load average: 1.39, 0.95, 0.44
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harry Brueckner wrote:

> ...
> FATAL: Module /dev/ttyx0
> FATAL: Module /dev/ttyx1
> FATAL: Module /dev/ttyx2
> FATAL: Module /dev/ttyx3
> FATAL: Module /dev/ttyx4
> FATAL: Module /dev/ttyx5
> ...

I had this, too. But it disappeared with test5-mm1 on my debian sid.
Try to update sysvinit. If that does not help, try with a newer kernel,
too.


claa. But it disappeared with test5-mm1 on my debian sid.
Try to update sysvinit. If that does not help, try with a newer kernel,
too.


claas
