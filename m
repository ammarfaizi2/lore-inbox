Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbUL1Xuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbUL1Xuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 18:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUL1Xuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 18:50:52 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28063 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261177AbUL1Xus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 18:50:48 -0500
Subject: Re: [patch 1/3] copy_to_user check in fs/cifs/file.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Steve French <sfrench@samba.org>, Steve French <sfrench@us.ibm.com>,
       samba-technical <samba-technical@lists.samba.org>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412290042480.3528@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412270019370.3552@dragon.hygekrogen.localhost>
	 <1104104286.16545.7.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0412290042480.3528@dragon.hygekrogen.localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104273945.26109.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Dec 2004 22:45:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-12-28 at 23:48, Jesper Juhl wrote:
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

Acked-by: Alan Cox <alan@redhat.com>

Looks good to me now.

