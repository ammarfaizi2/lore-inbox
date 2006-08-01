Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751691AbWHAPWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbWHAPWv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 11:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWHAPWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 11:22:50 -0400
Received: from thunk.org ([69.25.196.29]:13793 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751692AbWHAPWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 11:22:45 -0400
Date: Tue, 1 Aug 2006 11:22:36 -0400
From: Theodore Tso <tytso@mit.edu>
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, reiser@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: reiser4: maybe just fix bugs?
Message-ID: <20060801152235.GB362@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Denis Vlasenko <vda.linux@googlemail.com>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>, reiser@namesys.com,
	linux-kernel@vger.kernel.org
References: <200607311617.k6VGH3YH009055@laptop13.inf.utfsm.cl> <200607312206.42240.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607312206.42240.vda.linux@googlemail.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 10:06:42PM +0200, Denis Vlasenko wrote:
> > You are wrong. ReiserFS has no "right" to be allowed into the kernel.
> 
> JBD is factored out. So far it was a wasted effort - nobody uses
> JBD except ext3.

Not true.  ocfs2 uses the jbd layer....

					- Ted
