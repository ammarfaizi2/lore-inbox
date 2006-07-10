Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965232AbWGJVQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbWGJVQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 17:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965235AbWGJVQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 17:16:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:37298 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965232AbWGJVQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 17:16:27 -0400
Subject: Re: Linux v2.6.18-rc1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: will_schmidt@vnet.ibm.com
Cc: Steve Fox <drfickle@us.ibm.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1152537672.28828.4.camel@farscape.rchland.ibm.com>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	 <pan.2006.07.07.15.41.35.528827@us.ibm.com>
	 <1152441242.4128.33.camel@localhost.localdomain>
	 <1152537672.28828.4.camel@farscape.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 07:16:11 +1000
Message-Id: <1152566171.1576.98.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 08:21 -0500, Will Schmidt wrote:
> On Sun, 2006-09-07 at 20:34 +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2006-07-07 at 10:41 -0500, Steve Fox wrote:
> > > We've got a ppc64 machine that won't boot with this due to an IDE error.
> > 
> > What machine precisely ?
> 
> I see a slightly more verbose version on a JS20 blade. 

Can you try with the new patches I posted yesterday ?

Ben.


