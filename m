Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVA0NOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVA0NOi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 08:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVA0NOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 08:14:38 -0500
Received: from canuck.infradead.org ([205.233.218.70]:64782 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262613AbVA0NOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 08:14:35 -0500
Subject: Re: A scrub daemon (prezeroing)
From: David Woodhouse <dwmw2@infradead.org>
To: Robin Holt <holt@sgi.com>
Cc: Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050127131228.GB31288@lnx-holt.americas.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
	 <1106828124.19262.45.camel@hades.cambridge.redhat.com>
	 <20050127131228.GB31288@lnx-holt.americas.sgi.com>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 13:14:29 +0000
Message-Id: <1106831669.19262.75.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-27 at 07:12 -0600, Robin Holt wrote:
> An earlier proposal that Christoph pushed would have used the BTE on
> sn2 for this.  Are you thinking of using the BTE on sn0/sn1 mips?

I wasn't being that specific. There's spare DMA engines on a lot of
PPC/ARM/FRV/SH/MIPS and other machines, to name just the ones sitting
around my desk.

-- 
dwmw2

