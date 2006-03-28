Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWC1EzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWC1EzR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 23:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWC1EzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 23:55:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:38317 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751234AbWC1EzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 23:55:15 -0500
X-Authenticated: #14349625
Subject: Re: scheduler starvation resistance patches for 2.6.16
From: Mike Galbraith <efault@gmx.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060328041400.GJ21493@w.ods.org>
References: <1143434125.17567.11.camel@homer>
	 <20060328041400.GJ21493@w.ods.org>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 06:56:32 +0200
Message-Id: <1143521792.7441.1.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 06:14 +0200, Willy Tarreau wrote:
> On Mon, Mar 27, 2006 at 06:35:25AM +0200, Mike Galbraith wrote:
> > Greetings,
> > 
> > Knowing that not everybody runs the latest/greatest mm kernels, I've
> > adapted my scheduler starvation resistance tree to virgin 2.6.16.  Those
> > interested will find seven patches in the attached tarball.
> > 
> > Test feedback much appreciated.
> 
> Thanks Mike.
> 
> It will be easier to test, and I'll try to convince some people around
> me to give it a try. Do you expect the exact same behaviour as in -mm ?

Yes, it should.

	-Mike

