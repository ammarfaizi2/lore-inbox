Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbUAOIad (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 03:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266361AbUAOIac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 03:30:32 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38874 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265236AbUAOIac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 03:30:32 -0500
Date: Thu, 15 Jan 2004 00:21:15 -0800
From: "David S. Miller" <davem@redhat.com>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, linux-kernel@vger.kernel.org,
       rmk+lkml@arm.linux.org.uk, irda-users@lists.sourceforge.net
Subject: Re: [PATCH 2.6 IrDA] IrCOMM TTY API fix
Message-Id: <20040115002115.454f562e.davem@redhat.com>
In-Reply-To: <20040115033659.GA25325@bougret.hpl.hp.com>
References: <20040115033659.GA25325@bougret.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004 19:36:59 -0800
Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:

> 	Another bug fix, this time from Russell. This problem prevent some users to make connection to their phones over IrDA.
> 	Would you mind adding that to my previous batch of patches ?

Applied, thanks guys.
