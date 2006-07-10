Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161046AbWGJMxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbWGJMxc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 08:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbWGJMxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 08:53:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37825 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161046AbWGJMxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 08:53:22 -0400
Subject: Re: [RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with
	-Wshadow
From: Arjan van de Ven <arjan@infradead.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490607100548o14dbe684j40bde90eb19a7558@mail.gmail.com>
References: <9a8748490607100548o14dbe684j40bde90eb19a7558@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 14:53:19 +0200
Message-Id: <1152535999.4874.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So, what do people say?


Hi,

I'm just about always in favor of having automated tools help us find
bugs. However... can you give an indication of how many real bugs you
have encountered? If it's "mostly noise" all the time.. then it's maybe
not worth the effort... while if you find real bugs then it's obviously
worthwhile to go through this.

Greetings,
   Arjan van de Ven

