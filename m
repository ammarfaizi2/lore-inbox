Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263911AbTETTmQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 15:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263912AbTETTmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 15:42:16 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:27151 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263911AbTETTmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 15:42:15 -0400
Date: Tue, 20 May 2003 20:55:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] futex patches, futex-2.5.69-A2
Message-ID: <20030520205512.A5889@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
	Ulrich Drepper <drepper@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030520150826.A18282@infradead.org> <Pine.LNX.4.44.0305201748020.14480-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0305201748020.14480-100000@localhost.localdomain>; from mingo@elte.hu on Tue, May 20, 2003 at 06:02:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 06:02:07PM +0200, Ingo Molnar wrote:
> you havent ever used Ulrich's nptl-enabled glibc, have you? It will boot
> on any 2.4.1+ kernel, with and without nptl/tls support. It switches the
> threading implementation depending on the kernel features it detects.

I have built a nptl-enabled glibc and no, it's doesn't work on 2.4 at all.

