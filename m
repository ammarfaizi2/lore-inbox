Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbTLOVJj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 16:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbTLOVJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 16:09:39 -0500
Received: from greendale.ukc.ac.uk ([129.12.21.13]:63485 "EHLO
	greendale.ukc.ac.uk") by vger.kernel.org with ESMTP id S263985AbTLOVJi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 16:09:38 -0500
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Adams <padamsdev@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
References: <Pine.LNX.4.10.10312100419220.3805-100000@master.linux-ide.org>
From: Adam Sampson <azz@us-lot.org>
Organization: Don't wake me, 'cos I'm dreaming, and I might just stay inside
 again today.
Date: Mon, 15 Dec 2003 18:01:24 +0000
In-Reply-To: <Pine.LNX.4.10.10312100419220.3805-100000@master.linux-ide.org> (Andre
 Hedrick's message of "Wed, 10 Dec 2003 04:57:56 -0800 (PST)")
Message-ID: <y2abrqaarkb.fsf@cartman.at.fivegeeks.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-UKC-Mail-System: No virus detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick <andre@linux-ide.org> writes:

> OSL 1 and 2 are a preferred choice as they are slowly creaping into
> the kernel.

The problem with the OSL is that it requires mirror sites to get
anybody downloading OSL-licensed software from them to explicitly
agree to the license; this is simply not practical, and the result is
that it is not feasible to freely mirror OSL-licensed software. This
hasn't been fixed with OSL 2, and as such it would be an exceptionally
poor choice for any piece of software that you want to be widely
distributed, which certainly includes Linux.

-- 
Adam Sampson <azz@us-lot.org>                        <http://offog.org/>
