Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265799AbUG2R0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUG2R0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267474AbUG2RWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:22:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33460 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264833AbUG2RTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:19:51 -0400
Date: Thu, 29 Jul 2004 13:19:07 -0400
From: Alan Cox <alan@redhat.com>
To: Ben Greear <greearb@candelatech.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Message-ID: <20040729171907.GA29841@devserv.devel.redhat.com>
References: <20040728124256.GA31246@devserv.devel.redhat.com> <41081BC4.6040607@candelatech.com> <20040728221554.GA22747@devserv.devel.redhat.com> <4108291D.7000804@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4108291D.7000804@candelatech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 03:30:53PM -0700, Ben Greear wrote:
> So if you try to configure the MTU to 1504 using ifconfig or whatever,
> will that actually work?

It should work fine yes.
