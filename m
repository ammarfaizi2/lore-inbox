Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbVIHVjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbVIHVjV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 17:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVIHVjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 17:39:21 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:30395 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S965016AbVIHVjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 17:39:20 -0400
Message-ID: <47520.10.10.10.10.1126215555.squirrel@linux1>
In-Reply-To: <20050908203715.GA26675@mars.ravnborg.org>
References: <17416.1126211209@www78.gmx.net>
    <20050908203715.GA26675@mars.ravnborg.org>
Date: Thu, 8 Sep 2005 17:39:15 -0400 (EDT)
Subject: Re: git_linux addition ; genericity pls
From: "Sean" <seanlkml@sympatico.ca>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: "Fabian LoneStar Fr?d?rick" <fabian.frederick@gmx.fr>,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, September 8, 2005 4:37 pm, Sam Ravnborg said:

> cogito?
>
> cg-clone \
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/linus/linux-2.6.git \
> linux-2.6.git
>
> cd linux-2.6
> make menuconfig
>


The cogito shell scripts don't buy you as much as they once did.   For
example, the above procedure in raw git, is:

git clone
rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
linux-2.6

cd linux-2.6
make menuconfig


Cheers,
Sean


