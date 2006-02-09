Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbWBIERQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWBIERQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 23:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbWBIERP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 23:17:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47060 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161015AbWBIERP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 23:17:15 -0500
Date: Wed, 8 Feb 2006 20:16:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc2-mm1 patches don't apply
Message-Id: <20060208201644.568379d6.akpm@osdl.org>
In-Reply-To: <20060208194359.bd1c1a4b.pj@sgi.com>
References: <20060208194359.bd1c1a4b.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> The patchset for 2.6.16-rc2-mm1 seems borked.
> 
>  It contains patches in linus.patch that are already in 2.6.16-rc2.

<wget, wget>

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/broken-out/linus.patch
applies cleanly to
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.16-rc2.tar.bz2
