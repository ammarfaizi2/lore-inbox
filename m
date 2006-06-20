Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWFTWHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWFTWHb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWFTWHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:07:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34755 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751234AbWFTWHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:07:30 -0400
Date: Tue, 20 Jun 2006 15:10:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: <ravinandan.arakali@neterion.com>
Cc: tglx@linutronix.de, dgc@sgi.com, mingo@elte.hu, neilb@suse.de,
       jblunck@suse.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
       balbir@in.ibm.com, ananda.raju@neterion.com,
       leonid.grossman@neterion.com, jes@trained-monkey.org
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries
 list (2nd version)
Message-Id: <20060620151019.797f120c.akpm@osdl.org>
In-Reply-To: <006d01c694b1$4208c0f0$3e10100a@pc.s2io.com>
References: <20060619173712.1144b332.akpm@osdl.org>
	<006d01c694b1$4208c0f0$3e10100a@pc.s2io.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ravinandan Arakali" <ravinandan.arakali@neterion.com> wrote:
>
> Do you want the patch to be submitted to netdev(the mailing list that we
> usually submit to) ?

If the patches are a formal submission then please send them to Jeff,
netdev and I'd like a cc too.

If they are not considered quite ready for submission then please just send
them to myself, thanks.  A netdev cc would be appropriate as well.  Basically
I just want to get that sn2 machine to boot.

Generally it's better to cc too many mailing lists and individuals than too
few.
