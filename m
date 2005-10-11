Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbVJKAuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVJKAuB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 20:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVJKAuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 20:50:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33164 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751324AbVJKAuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 20:50:01 -0400
Date: Mon, 10 Oct 2005 17:49:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: OBATA Noboru <noboru.obata.ar@hitachi.com>
Cc: hyoshiok@miraclelinux.com, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
Message-Id: <20051010174931.223310de.akpm@osdl.org>
In-Reply-To: <20051006.211718.74749573.noboru.obata.ar@hitachi.com>
References: <20050921.205550.927509530.hyoshiok@miraclelinux.com>
	<20051006.211718.74749573.noboru.obata.ar@hitachi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OBATA Noboru <noboru.obata.ar@hitachi.com> wrote:
>
> > We had a Linux Kernel Dump Summit 2005.

I was rather expecting that the various groups which are interested in
crash dumping would converge around kdump once it was merged.  But it seems
that this is not the case and that work continues on other strategies.

Is that a correct impression?  If so, what shortcoming(s) in kdump are
causing people to be reluctant to use it?
