Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTJBIki (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 04:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTJBIki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 04:40:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12692 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263271AbTJBIkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 04:40:35 -0400
Date: Thu, 2 Oct 2003 01:36:20 -0700
From: "David S. Miller" <davem@redhat.com>
To: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
Cc: akpm@osdl.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0-test6][X25] timer cleanup
Message-Id: <20031002013620.6d8b6f10.davem@redhat.com>
In-Reply-To: <1065078208.4340.3.camel@lima.royalchallenge.com>
References: <1065018387.7194.336.camel@lima.royalchallenge.com>
	<20031001155623.06b89258.akpm@osdl.org>
	<1065078208.4340.3.camel@lima.royalchallenge.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Oct 2003 12:33:28 +0530
Vinay K Nallamothu <vinay.nallamothu@gsecone.com> wrote:

> On Thu, 2003-10-02 at 04:26, Andrew Morton wrote:
> > Vinay K Nallamothu <vinay.nallamothu@gsecone.com> wrote:
> > >
> > > Replace del_timer, mod_timer sequences with mod_timer.
> > 
> > was this tested?
> No. But compiles fine.

Please find a way to at least minimally test the protocols
you are changing then, or find someone else who can.

Thanks.
