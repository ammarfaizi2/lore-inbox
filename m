Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbVA1Szc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbVA1Szc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVA1SwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:52:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10472 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261515AbVA1Sua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:50:30 -0500
Date: Fri, 28 Jan 2005 18:50:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Arjan van de Ven <arjanv@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, viro@zenII.uk.linux.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: make flock_lock_file_wait static
Message-ID: <20050128185017.GA21760@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	Arjan van de Ven <arjanv@infradead.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	viro@zenII.uk.linux.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <1105346324.4171.16.camel@laptopd505.fenrus.org> <1105367014.11462.13.camel@lade.trondhjem.org> <1105432299.3917.11.camel@laptopd505.fenrus.org> <1105471004.12005.46.camel@lade.trondhjem.org> <1105472182.3917.49.camel@laptopd505.fenrus.org> <20050125185812.GA1499@us.ibm.com> <1106730061.6307.62.camel@laptopd505.fenrus.org> <20050126160715.GB1266@us.ibm.com> <1106765983.6307.134.camel@laptopd505.fenrus.org> <20050128141446.GA1868@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128141446.GA1868@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 06:14:46AM -0800, Paul E. McKenney wrote:
> In my experience, the only way to get exports into a major distribution
> is to get them into mainline kernel.org.  If you can get Red Hat to
> change its stance on this, works for me!

That's not the point.  You're trying to let us work for you for free
without any gain for us.

