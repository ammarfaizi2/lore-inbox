Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWCVJE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWCVJE3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWCVJE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:04:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4298 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751136AbWCVJE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:04:27 -0500
Subject: Re: [PATCH][5/8] proc: export mlocked pages info through
	"/proc/meminfo: Wired"
From: Arjan van de Ven <arjan@infradead.org>
To: Stone Wang <pwstone@gmail.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <bc56f2f0603212137s727ff0edu@mail.gmail.com>
References: <bc56f2f0603200537i7b2492a6p@mail.gmail.com>
	 <441FEFC7.5030109@yahoo.com.au> <bc56f2f0603210733vc3ce132p@mail.gmail.com>
	 <442098B6.5000607@yahoo.com.au>
	 <bc56f2f0603212137s727ff0edu@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 10:04:23 +0100
Message-Id: <1143018264.2955.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 00:37 -0500, Stone Wang wrote:
> The name "Wired" could be changed to which one most kids think better
> fits the job.
> 
> I choosed "Wired" for:
> "Locked" will conflict with PG_locked bit of a pags.
> "Pinned" indicates a short-term lock,so not fits the job too.

pinned does not imply short term

