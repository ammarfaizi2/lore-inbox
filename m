Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263822AbTH1Gvq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 02:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbTH1Gvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 02:51:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18655 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263822AbTH1Gvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 02:51:45 -0400
Date: Wed, 27 Aug 2003 23:42:18 -0700
From: "David S. Miller" <davem@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: jreuter@yaina.de, linux-net@vger.kernel.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix bpqether.c compile without CONFIG_PROC_FS
Message-Id: <20030827234218.52dde6c6.davem@redhat.com>
In-Reply-To: <20030827071215.GL7038@fs.tum.de>
References: <20030827071215.GL7038@fs.tum.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003 09:12:15 +0200
Adrian Bunk <bunk@fs.tum.de> wrote:

> I got the following compile error when trying to compile 2.6.0-test4-mm1 
> without CONFIG_PROC_FS (but this problem is most likely not limited to 
> -mm):

Applied, thanks.
