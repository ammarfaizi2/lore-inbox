Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267601AbUHTGdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267601AbUHTGdv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 02:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267599AbUHTGdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 02:33:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:22752 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267597AbUHTGdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 02:33:44 -0400
Date: Thu, 19 Aug 2004 23:31:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: garloff@suse.de, mason@suse.com, axboe@suse.de, antisthenes@inbox.ru,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bio_uncopy_user mem leak
Message-Id: <20040819233155.68c1411e.akpm@osdl.org>
In-Reply-To: <41256DC9.7070500@kolivas.org>
References: <1092909598.8364.5.camel@localhost>
	<412489E5.7000806@kolivas.org>
	<1092923494.12138.1667.camel@watt.suse.com>
	<20040819195521.GC12363@tpkurt.garloff.de>
	<41256DC9.7070500@kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
>  Andrew did you threaten to make a 2.6.8.2 since 2.6.8{,.1} cannot safely 
>  burn an audio cd?

Uh, I guess that depends on how rested Linus feels when he returns.  I
think there's a fairly significant networking fix too.  As I said: we'll see.
