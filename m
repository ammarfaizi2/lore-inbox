Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVCGRgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVCGRgT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 12:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVCGRgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 12:36:19 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:34579 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261173AbVCGRgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 12:36:17 -0500
Date: Mon, 7 Mar 2005 12:35:56 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
Message-ID: <20050307173554.GA4217@tuxdriver.com>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
	torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050304222146.GA1686@kroah.com> <20050306094451.GA21907@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050306094451.GA21907@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 06:44:51AM -0300, Marcelo Tosatti wrote:

> >  - It must fix a problem that causes a build error (but not for things
> >    marked CONFIG_BROKEN), an oops, a hang, or a real security issue. 
> 
> "and breakage of previously working functionality" ? 

I'd vote to include this one...

John
-- 
John W. Linville
linville@tuxdriver.com
