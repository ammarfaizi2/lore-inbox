Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUE1Nh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUE1Nh5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 09:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUE1Nh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 09:37:57 -0400
Received: from [213.146.154.40] ([213.146.154.40]:31926 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263062AbUE1Nh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 09:37:56 -0400
Date: Fri, 28 May 2004 14:37:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: Dave Jones <davej@redhat.com>, Andrey Panin <pazke@donpac.ru>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/13] 2.6.7-rc1-mm1, Simplify DMI matching data
Message-ID: <20040528133745.GA28167@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@muc.de>, Dave Jones <davej@redhat.com>,
	Andrey Panin <pazke@donpac.ru>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20Oc4-HT-25@gated-at.bofh.it> <m3zn7su4lv.fsf@averell.firstfloor.org> <20040528125447.GB11265@redhat.com> <20040528132358.GA78847@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528132358.GA78847@colin2.muc.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 03:23:58PM +0200, Andi Kleen wrote:
> My point stays that kernel interfaces should stay stable in the stable
> series as far as possible (= unless terminally broken, but that's
> clearly not the case here).  If you feel the need to clean up
> something better wait for the unstable series.

So what interface doews the patch break?  I can only see that it
adds interfaces.
