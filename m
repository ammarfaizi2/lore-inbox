Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUFBKdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUFBKdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 06:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUFBKdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 06:33:45 -0400
Received: from [213.146.154.40] ([213.146.154.40]:24045 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261602AbUFBKdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 06:33:44 -0400
Date: Wed, 2 Jun 2004 11:33:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Abandoned code in include/linux/
Message-ID: <20040602103343.GA32302@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alexey Dobriyan  <adobriyan@mail.ru>, linux-kernel@vger.kernel.org
References: <E1BVSMH-0005JE-00.adobriyan-mail-ru@f17.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BVSMH-0005JE-00.adobriyan-mail-ru@f17.mail.ru>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 01:48:29PM +0400, "Alexey Dobriyan"  wrote:
> include/linux/atapi.h

this is from Martin's 2.5 ide rewrite, I'd like to ressurect is sooner
or later.  But if it's removed I'd still have a copy.

> include/linux/fsfilter.h

this was intermezzo code, should be safe to remove.

> include/linux/in_systm.h

doesn't seem to be used for ages :)

> include/linux/mpp.h

ap1000 support was removed ages ago, should be safe to kill.

> include/linux/netbeui.h

