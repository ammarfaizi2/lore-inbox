Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268258AbUIGU6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268258AbUIGU6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268592AbUIGU6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 16:58:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:18580 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268258AbUIGU6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 16:58:36 -0400
Date: Tue, 7 Sep 2004 13:56:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: arjanv@redhat.com, hch@infradead.org,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Where's the key management patchset at?
Message-Id: <20040907135631.0ef139e0.akpm@osdl.org>
In-Reply-To: <22970.1094563283@redhat.com>
References: <20040907033255.78128ebd.akpm@osdl.org>
	<20040907031856.58f33b99.akpm@osdl.org>
	<20040904032913.441631e6.akpm@osdl.org>
	<20040904022656.31447b51.akpm@osdl.org>
	<20040903224513.0154c1d3.akpm@osdl.org>
	<24752.1094234169@redhat.com>
	<12766.1094289316@redhat.com>
	<14279.1094293508@redhat.com>
	<13781.1094551789@redhat.com>
	<14622.1094552807@redhat.com>
	<22970.1094563283@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> I'd like to dispense with keyfs.

Let's do that then.  I'll keep the patch alive in -mm.  If someone can come
along and demonstrate a solid reason for needing keyfs then we can
reevaluate.
