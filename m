Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTEFMRv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTEFMQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:16:47 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:53243 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id S262676AbTEFMQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:16:11 -0400
Date: Tue, 6 May 2003 13:31:42 +0100
From: Robert Murray <rob@mur.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: failed assertions in 2.4.20 networking code
Message-ID: <20030506123142.GI2388@mur.org.uk>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20030506112512.GH2388@mur.org.uk> <1052222662.983.29.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052222662.983.29.camel@rth.ninka.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Thanks for the quick responce.  is this bug likely to cause any problems? I havn't noticed anything.

Cheers

Rob
On Tue, May 06, 2003 at 05:04:23AM -0700, David S. Miller wrote:
> On Tue, 2003-05-06 at 04:25, Robert Murray wrote:
> > I'm getting the following messages with 2.4.20.  This machine is
> > acting as a server and a router between an adsl line and my LAN.  I
> > will send my iptables and tc setup if it is necessary to diagnose the
> > problem.
> 
> This bug is fixed in current 2.4.x sources.
> 
> -- 
> David S. Miller <davem@redhat.com>
