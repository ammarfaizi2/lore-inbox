Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVAGIPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVAGIPo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 03:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVAGIPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 03:15:44 -0500
Received: from [213.146.154.40] ([213.146.154.40]:55224 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261308AbVAGIPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 03:15:40 -0500
Date: Fri, 7 Jan 2005 08:15:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: paulmck@us.ibm.com, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050107081535.GB4511@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjan@infradead.org>, paulmck@us.ibm.com,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
	pbadari@us.ibm.com, markv@us.ibm.com, greghk@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <1105083213.4179.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105083213.4179.1.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 08:33:32AM +0100, Arjan van de Ven wrote:
> eh maybe a weird question, but why are you and not the MVFS guys asking
> for this export then? They can probably better explain why they need
> it ....

Because an person known to the communicity can justify IBM's illegal and
copyright-infringe than someone totally unkown?  Paul did the same already
for GPFS and the unmapping_range stuff, and Greg told me has was asked
similar things repeatedly but refused.

It really seems like IBM wants to abuse the positition the it's employees
archived contribution to opesource projects.
