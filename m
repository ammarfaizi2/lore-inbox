Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbWAKGpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbWAKGpO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbWAKGpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:45:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46790 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932643AbWAKGpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:45:12 -0500
Date: Tue, 10 Jan 2006 22:44:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why no -mm git tree?
Message-Id: <20060110224451.44c9d3da.akpm@osdl.org>
In-Reply-To: <20060111055616.GA5976@localhost.localdomain>
References: <20060111055616.GA5976@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:
>
> Why don't use a -mm git tree?
>

Because everthing would take me 100x longer?

I'm looking into generating a pullable git tree for each -mm.  Just as a
convenience for people who can't type "ftp".

That'll just be a dump of the whole -mm lineup into git.  I don't know how
workable it'll be - we'll see.
