Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264633AbUGIVUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbUGIVUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 17:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUGIVUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 17:20:14 -0400
Received: from [213.146.154.40] ([213.146.154.40]:34993 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264633AbUGIVUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 17:20:08 -0400
Date: Fri, 9 Jul 2004 22:20:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jean-Christophe Dubois <jdubois@mc.com>
Subject: Re: [PATCH] Fix building on Solaris (and don't break Cygwin)
Message-ID: <20040709212004.GA6203@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tom Rini <trini@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jean-Christophe Dubois <jdubois@mc.com>
References: <20040709210011.GG28002@smtp.west.cox.net> <20040709211605.GA6126@infradead.org> <20040709211853.GH28002@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709211853.GH28002@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 02:18:53PM -0700, Tom Rini wrote:
> I forgot to CC Jean on this, but that's not exactly a nice option.  In
> fact, it'd be fine to just switch to <inttypes.h>, afaics, except that
> cygwin doesn't have that.

Tell him to build on Linux, we don't support legacy OSes ;-)
