Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759803AbWLDFDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759803AbWLDFDz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 00:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759811AbWLDFDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 00:03:55 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43702 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1759803AbWLDFDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 00:03:55 -0500
Date: Sun, 3 Dec 2006 21:03:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Corey Minyard <minyard@acm.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Joseph Barnett <jbarnett@motorola.com>
Subject: Re: [PATCH 9/12] IPMI: add pigeonpoint poweroff
Message-Id: <20061203210340.9292061d.akpm@osdl.org>
In-Reply-To: <45738959.1000209@acm.org>
References: <20061202043746.GE30531@localdomain>
	<20061203132618.d7d58f59.akpm@osdl.org>
	<45738959.1000209@acm.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Dec 2006 20:35:05 -0600
Corey Minyard <minyard@acm.org> wrote:

> Do you prefer patches to fold into the existing patches or new versions?

Incremental updates are preferred where it makes sense, please.  That way
we can see what changed.  I often will convert updated patches into
incremental patches just to see what happened.  I've caught bugs that way..
