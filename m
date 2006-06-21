Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWFUL2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWFUL2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 07:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWFUL2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 07:28:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35204 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751332AbWFUL2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 07:28:38 -0400
Date: Wed, 21 Jun 2006 04:28:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
Message-Id: <20060621042830.a11e87ff.akpm@osdl.org>
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
References: <20060621034857.35cfe36f.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 03:48:57 -0700
Andrew Morton <akpm@osdl.org> wrote:

> - ia64 doesn't compile for me, due to git-klibc problems (a truly ancient
>   toolchain might be implicated).

Actually I did do a full ia64 allmodconfig build on a recent distro.  So
it's "broken on RHAS 2.1".

