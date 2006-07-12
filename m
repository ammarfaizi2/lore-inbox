Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWGLFGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWGLFGr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 01:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWGLFGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 01:06:47 -0400
Received: from xenotime.net ([66.160.160.81]:11672 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932406AbWGLFGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 01:06:47 -0400
Date: Tue, 11 Jul 2006 22:09:34 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mchehab@infradead.org
Subject: Re: [PATCH -mm] bttv: must_check fixes
Message-Id: <20060711220934.3e99565e.rdunlap@xenotime.net>
In-Reply-To: <20060711220148.13257f96.akpm@osdl.org>
References: <20060711204421.be13dec9.rdunlap@xenotime.net>
	<20060711220148.13257f96.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 22:01:48 -0700 Andrew Morton wrote:

> On Tue, 11 Jul 2006 20:44:21 -0700
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> 
> > Check all __must_check warnings in bttv.
> 
> Thanks.
> 
> The descriptions do rather miss the point: the objective is not to squish the
> __must_check warnings - it is to detect and handler error conditions.

Ack.  Will fix my fingers.

---
~Randy
