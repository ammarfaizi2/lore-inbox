Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264858AbUFHGSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264858AbUFHGSb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 02:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264863AbUFHGSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 02:18:31 -0400
Received: from may.priocom.com ([213.156.65.50]:7336 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S264858AbUFHGSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 02:18:30 -0400
Subject: Re: [PATCH] 2.6.6 memory allocation checks in
From: Yury Umanets <torque@ukrpost.net>
To: Steve French <smfltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1086646703.5214.10.camel@stevef95.austin.ibm.com>
References: <1086646703.5214.10.camel@stevef95.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1086675459.2818.7.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 08 Jun 2004 09:17:39 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-08 at 01:18, Steve French wrote:
> > Adds memory allocation checks in cifs_parse_mount_options().
> > ./linux-2.6.6-modified/fs/cifs/connect.c |    4 ++++
> > 1 files changed, 4 insertions(+)
> 
> I pushed the change to the project tree
> 	bk://cifs.bkbits.net/linux-2.5cifs
> and will send that in with the next group of cifs bk changesets later in
> the week.

Thanks.

> 
> Thanks.
-- 
umka

