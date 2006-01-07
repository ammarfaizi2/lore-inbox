Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWAGAvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWAGAvK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWAGAvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:51:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27627 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030260AbWAGAvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:51:07 -0500
Date: Fri, 6 Jan 2006 16:52:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, arjan@infradead.org,
       nico@cam.org, jes@trained-monkey.org, viro@ftp.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk,
       hch@infradead.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 01/21] mutex subsystem, add atomic_xchg() to all arches
Message-Id: <20060106165217.34573364.akpm@osdl.org>
In-Reply-To: <20060105153658.GB31013@elte.hu>
References: <20060105153658.GB31013@elte.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


s390's atomic.h changed in current -linus.  Please check.
