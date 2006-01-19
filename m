Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161415AbWASUsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161415AbWASUsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161420AbWASUsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:48:12 -0500
Received: from adsl-67-65-19-105.dsl.austtx.swbell.net ([67.65.19.105]:11866
	"EHLO mail.es335.com") by vger.kernel.org with ESMTP
	id S1161415AbWASUsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:48:11 -0500
Subject: Re: [openib-general] Re: RFC: ipath ioctls and their replacements
From: Steve Wise <swise@opengridcomputing.com>
Reply-To: swise@opengridcomputing.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <m1slrkneqq.fsf@ebiederm.dsl.xmission.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	 <m1y81cpqt8.fsf@ebiederm.dsl.xmission.com>
	 <1137688158.3693.29.camel@serpentine.pathscale.com>
	 <m1hd80oz9b.fsf@ebiederm.dsl.xmission.com>
	 <1137696611.3693.63.camel@serpentine.pathscale.com>
	 <m1slrkneqq.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: OGC
Date: Thu, 19 Jan 2006 14:47:57 -0600
Message-Id: <1137703677.2744.22.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For those who need the buzz words to understand what is going
> on the ipath hardware largely does stateless offload for IB while
> the mellanox hardware does whole protocol offload.  Which would
> mean if this was a normal network driver ipath good mellanox bad.
> 

Are you sure about this?  I would think if ipath does IB RC service in
hardware, its no where near stateless offload.  I don't think this is a
fair comparison.

Steve.




