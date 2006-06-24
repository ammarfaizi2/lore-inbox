Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWFXNYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWFXNYu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 09:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWFXNYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 09:24:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41432 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964834AbWFXNYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 09:24:49 -0400
Date: Sat, 24 Jun 2006 06:24:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: greg@kroah.com, gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64bit resources start end value fix
Message-Id: <20060624062441.8ae6070f.akpm@osdl.org>
In-Reply-To: <20060624131555.GB980@in.ibm.com>
References: <20060621172903.GC9423@in.ibm.com>
	<20060624024513.GB29637@kroah.com>
	<20060624131555.GB980@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2006 09:15:55 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> Everything seems to be fine except that following i2c patch from andrew
> seems to be missing.
> 
> http://marc.theaimsgroup.com/?l=linux-mm-commits&m=115086650916817&w=2

That's not altogether unusual.

Thursday is supposed to be my send-patches-for-maintainers-to-ignore day
but I didn't get onto it.   Soon...
