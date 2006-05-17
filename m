Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWEQCE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWEQCE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 22:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWEQCE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 22:04:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750811AbWEQCE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 22:04:56 -0400
Date: Tue, 16 May 2006 18:58:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] fs/jbd/journal.c: possible cleanups
Message-Id: <20060516185817.41cf92c0.akpm@osdl.org>
In-Reply-To: <1147830710.3051.7.camel@laptopd505.fenrus.org>
References: <20060516174413.GI10077@stusta.de>
	<20060516122731.6ecbdeeb.akpm@osdl.org>
	<1147829611.3051.5.camel@laptopd505.fenrus.org>
	<20060516184042.2e292ad9.akpm@osdl.org>
	<1147830710.3051.7.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> 
> > I don't think we should take the scattergun approach here.  Get the
> > infrastructure merged,
> 
> that should be relatively easy... would you mind doing it via your tree?

Sure.

