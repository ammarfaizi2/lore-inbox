Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161446AbWASVxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161446AbWASVxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161447AbWASVxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:53:44 -0500
Received: from mx.pathscale.com ([64.160.42.68]:48015 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1161446AbWASVxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:53:43 -0500
Subject: Re: [openib-general] Re: RFC: ipath ioctls and their replacements
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sean Hefty <mshefty@ichips.intel.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <m1oe28nemx.fsf@ebiederm.dsl.xmission.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	 <m1y81cpqt8.fsf@ebiederm.dsl.xmission.com>
	 <1137688158.3693.29.camel@serpentine.pathscale.com>
	 <m1hd80oz9b.fsf@ebiederm.dsl.xmission.com>
	 <43CFDF5F.5060409@ichips.intel.com>
	 <1137696901.3693.66.camel@serpentine.pathscale.com>
	 <m1oe28nemx.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 19 Jan 2006 13:53:43 -0800
Message-Id: <1137707623.3693.97.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 13:31 -0700, Eric W. Biederman wrote:

> Ok this is one piece of the puzzle.  At your lowest level your hardware
> does not have QP's but it does have something similar to isolate a userspace
> process correct?

Right.  We implement almost none of the IB protocols in hardware.

	<b

