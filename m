Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbUK0Ch5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbUK0Ch5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbUK0CFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:05:37 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262755AbUKZThJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:37:09 -0500
Date: Thu, 25 Nov 2004 10:10:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, hugang@soulinfo.com,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Suspend 2 merge: 46/51: LZF support.
Message-ID: <20041125101032.GB29539@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, hugang@soulinfo.com,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101350324.25030.0.camel@desktop.cunninghams> <20041125063242.GA31753@hugang.soulinfo.com> <200411250152.33330.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411250152.33330.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since this is a completely new file (as far as kernel tree is concerned)
> could you convert it to proper coding style (braces placement, identation)?

While I'm normally a big advocate of sane indentation it looks like these
two files are taken unmodified from some external library and are unlike to
be modified.  Maybe keep them as is to ease a possible future resync (and
comparisms with upstream) ?

