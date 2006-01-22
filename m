Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWAVT7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWAVT7W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 14:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWAVT7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 14:59:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32742 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751328AbWAVT7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 14:59:22 -0500
Date: Sun, 22 Jan 2006 11:58:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: acahalan@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add /proc/*/pmap files
Message-Id: <20060122115856.42231368.akpm@osdl.org>
In-Reply-To: <1137959059.3328.45.camel@laptopd505.fenrus.org>
References: <787b0d920601220150n2e34e376i856cc583a372e1f2@mail.gmail.com>
	<1137940577.3328.14.camel@laptopd505.fenrus.org>
	<787b0d920601221117l78a92fd1udc8601068dbde42c@mail.gmail.com>
	<1137959059.3328.45.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
>  you're making a NEW file

One which, afaict, contains the same thing as /proc/pid/smaps only in a
different format.  If there's a point to this patch, we weren't told what
it is.

