Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbTGSIGJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 04:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270515AbTGSIGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 04:06:09 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:61192 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265766AbTGSIGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 04:06:07 -0400
Date: Sat, 19 Jul 2003 09:21:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre7
Message-ID: <20030719092103.A19754@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0307181649290.29493@freak.distro.conectiva> <1058569601.544.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1058569601.544.1.camel@teapot.felipe-alfaro.com>; from felipe_alfaro@linuxmail.org on Sat, Jul 19, 2003 at 01:06:41AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 01:06:41AM +0200, Felipe Alfaro Solana wrote:
> > Here goes -pre7.
> 
> Will ACL/xattr support get its way onto mainstream 2.4 soon?

xattr support is in 2.4 mainline although only JFS currently support
it.
