Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbUKJXam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbUKJXam (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 18:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbUKJXal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 18:30:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39812 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261625AbUKJXai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 18:30:38 -0500
Date: Wed, 10 Nov 2004 15:22:15 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Nigel Kukard <nkukard@lbsd.net>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: ub vs. usb-storage
Message-ID: <20041110152215.4e00206b@lembas.zaitcev.lan>
In-Reply-To: <mailman.1100001301.9189.linux-kernel2news@redhat.com>
References: <mailman.1100001301.9189.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Nov 2004 11:50:20 +0000, Nigel Kukard <nkukard@lbsd.net> wrote:

> Using kernel 2.6.9 bk7 and the UB driver for mass-storage I seem to see 
> spikes on the load-avg of over 700. There is also times of extreme 
> responsiveness deficiency.

This sounds curious. I'd like to hear more about it. Is there anything
interesting in dmesg?

-- Pete
