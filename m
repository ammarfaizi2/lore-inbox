Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422682AbWASXor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422682AbWASXor (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 18:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422688AbWASXor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 18:44:47 -0500
Received: from mx.pathscale.com ([64.160.42.68]:13723 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422682AbWASXoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 18:44:46 -0500
Subject: Re: RFC: ipath ioctls and their replacements
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20060119225716.GB27689@kroah.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	 <20060119025741.GC15706@kroah.com>
	 <1137646957.25584.17.camel@localhost.localdomain>
	 <20060119053940.GB21467@kroah.com>
	 <1137649988.25584.67.camel@localhost.localdomain>
	 <20060119225716.GB27689@kroah.com>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 15:44:19 -0800
Message-Id: <1137714259.22241.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 14:57 -0800, Greg KH wrote:

> The RDMA-loving people need to get together and hammer out a proposal
> that the network people can laugh at and shoot down all at once :)

We are not really in the RDMA camp.  Our facility looks more like "when
this kind of message comes in, be sure that it shows up at this point in
my address space", which does not match RDMA semantics.

Also, RDMA's mother smells of elderberries, in my personal opinion.

	<b

