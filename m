Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVGLCZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVGLCZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 22:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVGLCZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 22:25:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5774 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261771AbVGLCZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 22:25:40 -0400
Date: Tue, 12 Jul 2005 03:25:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, karim@opersys.com,
       varap@us.ibm.com, richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
Message-ID: <20050712022537.GA26128@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
	richardj_moore@uk.ibm.com
References: <17107.6290.734560.231978@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17107.6290.734560.231978@tut.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 08:10:42PM -0500, Tom Zanussi wrote:
> 
> Hi Andrew, can you please merge relayfs?  It provides a low-overhead
> logging and buffering capability, which does not currently exist in
> the kernel.

While the code is pretty nicely in shape it seems rather pointless to
merge until an actual user goes with it.

