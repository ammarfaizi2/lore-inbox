Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVAKEu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVAKEu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 23:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVAKEuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 23:50:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:34248 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262385AbVAKEtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 23:49:42 -0500
Date: Mon, 10 Jan 2005 20:49:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: aebr@win.tue.nl, bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: Do PS/2 ESDI users exist?
Message-Id: <20050110204909.2703d7af.akpm@osdl.org>
In-Reply-To: <20050111043220.GB2760@pclin040.win.tue.nl>
References: <20050108214036.GW14108@stusta.de>
	<20050108234337.GE6052@pclin040.win.tue.nl>
	<20050111043220.GB2760@pclin040.win.tue.nl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> wrote:
>
> I wonder whether ps2esdi should be removed.
>  Does the present driver work for someone?
>  Have there been users in this millennium? With 2.3 or later?

We could mark it CONFIG_BROKEN, leave it six months or so, see if anyone
complains.
