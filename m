Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTEDOpq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 10:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTEDOpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 10:45:46 -0400
Received: from rth.ninka.net ([216.101.162.244]:4533 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263600AbTEDOpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 10:45:45 -0400
Subject: Re: [PATCH] list.h: implement list_for_each_entry_safe
From: "David S. Miller" <davem@redhat.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030504075748.GD12549@conectiva.com.br>
References: <20030504075748.GD12549@conectiva.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052052632.27465.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 May 2003 05:50:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-04 at 00:57, Arnaldo Carvalho de Melo wrote:
> ChangeSet@1.1219, 2003-05-04 04:39:21-03:00, acme@conectiva.com.br
>   o list.h: implement list_for_each_entry_safe

Exists already, there is even a _rcu version.

-- 
David S. Miller <davem@redhat.com>
