Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264323AbTLEP53 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 10:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTLEP53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 10:57:29 -0500
Received: from ezoffice.mandrakesoft.com ([212.11.15.34]:8377 "EHLO
	vador.mandrakesoft.com") by vger.kernel.org with ESMTP
	id S264323AbTLEP52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 10:57:28 -0500
To: "Kendall Bennett" <KendallB@scitechsoft.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
X-URL: <http://www.linux-mandrake.com/
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
	<3FCF77FF.18046.447204E6@localhost>
From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Organization: MandrakeSoft
Date: Fri, 05 Dec 2003 15:57:27 +0000
In-Reply-To: <3FCF77FF.18046.447204E6@localhost> (Kendall Bennett's message
 of "Thu, 04 Dec 2003 18:07:59 -0800")
Message-ID: <m2y8tr2r6g.fsf@vador.mandrakesoft.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kendall Bennett" <KendallB@scitechsoft.com> writes:

> Then again, it appears that most developers are using wrapped to
> avoid this situation, such that their private code does not include
> any Linux headers, only the GPL'ed wrapper.

wrappers are gpl-ed.
i do not think they offer so much "work" that their authors have the
right to tell "here's there's a boundary; our binary module can
legally use our wrapper".

