Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWCVJqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWCVJqY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWCVJqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:46:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38857 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751168AbWCVJqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:46:23 -0500
Subject: Re: [RFC PATCH 04/35] Hypervisor interface header files.
From: Arjan van de Ven <arjan@infradead.org>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>
In-Reply-To: <0ffa39bba1c9a708536286f4bb80d605@cl.cam.ac.uk>
References: <20060322063040.960068000@sorel.sous-sol.org>
	 <20060322063744.407582000@sorel.sous-sol.org>
	 <1143016080.2955.7.camel@laptopd505.fenrus.org>
	 <0ffa39bba1c9a708536286f4bb80d605@cl.cam.ac.uk>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 10:46:16 +0100
Message-Id: <1143020777.2955.51.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 09:31 +0000, Keir Fraser wrote:
> On 22 Mar 2006, at 08:28, Arjan van de Ven wrote:
> 
> >> + * This file may be distributed separately from the Linux kernel, or
> >> + * incorporated into other software packages, subject to the 
> >> following license:
> >> + *
> >
> > and what, if any, is the license when distributed with the kernel, as
> > you propose? Right now there doesn't seem to be any at all, and thus it
> > would be undistributable.
> 
> I thought GPLv2 would be implicit.

implicit license == bad :)




