Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWEQBwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWEQBwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 21:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWEQBwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 21:52:12 -0400
Received: from e-nvb.com ([69.27.17.200]:5857 "EHLO e-nvb.com")
	by vger.kernel.org with ESMTP id S932422AbWEQBwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 21:52:12 -0400
Subject: Re: [RFC: 2.6 patch] fs/jbd/journal.c: possible cleanups
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060516184042.2e292ad9.akpm@osdl.org>
References: <20060516174413.GI10077@stusta.de>
	 <20060516122731.6ecbdeeb.akpm@osdl.org>
	 <1147829611.3051.5.camel@laptopd505.fenrus.org>
	 <20060516184042.2e292ad9.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 17 May 2006 03:51:29 +0200
Message-Id: <1147830710.3051.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't think we should take the scattergun approach here.  Get the
> infrastructure merged,

that should be relatively easy... would you mind doing it via your tree?

>  then methodically work the EXPORT_SYMBOL patches
> with the various maintainers.

yep but that needs step 1 to happen or they won't / can't take them...



