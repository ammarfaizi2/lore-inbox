Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbTIEHl2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 03:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbTIEHl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 03:41:28 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:63248 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261946AbTIEHl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 03:41:27 -0400
Date: Fri, 5 Sep 2003 08:41:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Florian Zimmermann <florian.zimmermann@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test-x] Kernel Oops and pppd segfault
Message-ID: <20030905084126.A15120@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Florian Zimmermann <florian.zimmermann@gmx.net>,
	linux-kernel@vger.kernel.org
References: <1062711059.8011.4.camel@mindfsck>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1062711059.8011.4.camel@mindfsck>; from florian.zimmermann@gmx.net on Thu, Sep 04, 2003 at 11:30:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 11:30:59PM +0200, Florian Zimmermann wrote:
> I have posted that to linux-ppp mailing list, but
> no answer for 2 weeks now..

This should fix the oops, but the failure is still strange.

do you already have a ppp device in /dev before loading the module?
