Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVA1OPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVA1OPQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVA1OPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:15:14 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:23223 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261408AbVA1OO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:14:58 -0500
Date: Fri, 28 Jan 2005 06:14:46 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Arjan van de Ven <arjanv@infradead.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, viro@zenII.uk.linux.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: make flock_lock_file_wait static
Message-ID: <20050128141446.GA1868@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1105345168.4171.11.camel@laptopd505.fenrus.org> <1105346324.4171.16.camel@laptopd505.fenrus.org> <1105367014.11462.13.camel@lade.trondhjem.org> <1105432299.3917.11.camel@laptopd505.fenrus.org> <1105471004.12005.46.camel@lade.trondhjem.org> <1105472182.3917.49.camel@laptopd505.fenrus.org> <20050125185812.GA1499@us.ibm.com> <1106730061.6307.62.camel@laptopd505.fenrus.org> <20050126160715.GB1266@us.ibm.com> <1106765983.6307.134.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106765983.6307.134.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 07:59:42PM +0100, Arjan van de Ven wrote:
> On Wed, 2005-01-26 at 08:07 -0800, Paul E. McKenney wrote:
> 
> > > Another question: is the SDD module even available for mainline kernels,
> > > or is it only available for distribution kernels ?
> > 
> > Distributions only.
> 
> don't you think it's a bit weird/offensive to ask for exports in the
> mainline kernel.org kernel while all you care about is certain vendor
> kernels and never plan to provide it for mainline????

In my experience, the only way to get exports into a major distribution
is to get them into mainline kernel.org.  If you can get Red Hat to
change its stance on this, works for me!

						Thanx, Paul
