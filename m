Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271336AbTHHNZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 09:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271337AbTHHNZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 09:25:14 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:56556 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S271336AbTHHNZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 09:25:11 -0400
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
From: David Woodhouse <dwmw2@infradead.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Nicolas Pitre <nico@cam.org>, Willy Tarreau <willy@w.ods.org>,
       Christoph Hellwig <hch@lst.de>, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <200307290102.01313.bernie@develer.com>
References: <Pine.LNX.4.44.0307281307480.6507-100000@xanadu.home>
	 <200307290102.01313.bernie@develer.com>
Content-Type: text/plain
Message-Id: <1060349104.25209.364.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Fri, 08 Aug 2003 14:25:04 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-29 at 00:02, Bernardo Innocenti wrote:
> I've read in the Kconfig help that JFFS2 still depends on mtdblock even
> though it doesn't use it for I/O. I think I've also seen some promise
> that this dependency will eventually be removed...

It's already been removed from everything but the Kconfig file... :)

-- 
dwmw2

