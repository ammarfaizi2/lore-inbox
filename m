Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTDXJeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbTDXJeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:34:20 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:64529 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262577AbTDXJeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:34:18 -0400
Date: Thu, 24 Apr 2003 10:46:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Christoph Hellwig <hch@infradead.org>, Mika Kukkonen <mika@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, cgl_discussion@osdl.org,
       Mark Huth <mark.huth@mvista.com>, Tigran Aivazian <tigran@veritas.com>
Subject: Re: OSDL CGL-WG draft specs available for review
Message-ID: <20030424104620.A25801@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Mika Kukkonen <mika@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
	cgl_discussion@osdl.org, Mark Huth <mark.huth@mvista.com>,
	Tigran Aivazian <tigran@veritas.com>
References: <1051044403.1384.44.camel@miku-t21-redhat.koti> <20030423174958.A2603@infradead.org> <3EA7B0D1.8090604@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EA7B0D1.8090604@gmx.net>; from c-d.hailfinger.kernel.2003@gmx.net on Thu, Apr 24, 2003 at 11:39:29AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 11:39:29AM +0200, Carl-Daniel Hailfinger wrote:
> IIRC, Mark Huth from MontaVista and Tigran Aivazian from Veritas both
> developed such an implementation independently of each other.
> Maybe they can offer some insight.

Tigran had a revoke(2) implementation - that's forced revokation of
a fd, not forced umount.  But maybe he did forced umount, too? :)

