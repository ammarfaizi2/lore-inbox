Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752139AbWCFHtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbWCFHtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbWCFHtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:49:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23259 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752139AbWCFHtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:49:49 -0500
Subject: Re: [OT] inotify hack for locate
From: Arjan van de Ven <arjan@infradead.org>
To: jonathan@jonmasters.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com>
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 08:49:45 +0100
Message-Id: <1141631385.4084.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-05 at 21:36 +0000, Jon Masters wrote:
> Folks,
> 
> I'm fed up with those finds running whenever I power on. Has anyone
> written an equivalent of the Microsoft indexing service to update
> locate's database?


there is both rlocate and mlocate to replace whatever variant of locate
you are using.

But this is obviously offtopic for lkml

