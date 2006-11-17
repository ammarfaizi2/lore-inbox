Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756032AbWKQX1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbWKQX1x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 18:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756035AbWKQX1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 18:27:53 -0500
Received: from twinlark.arctic.org ([207.7.145.18]:29891 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1756032AbWKQX1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 18:27:52 -0500
Date: Fri, 17 Nov 2006 15:27:51 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: martin f krafft <madduck@madduck.net>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: How to interpret MCE messages?
In-Reply-To: <20061115092726.GA22720@piper.oerlikon.madduck.net>
Message-ID: <Pine.LNX.4.64.0611171524400.12661@twinlark.arctic.org>
References: <20061108162022.GA4258@piper.madduck.net>
 <1163003354.23956.43.camel@localhost.localdomain>
 <20061115092726.GA22720@piper.oerlikon.madduck.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006, martin f krafft wrote:

> Thus I guess the CPU is asking for retirement. I am just
> double-checking with you guys whether I can be sure that it's only
> the CPU, or whether it could also be the fault of the motherboard...

could be VRMs and/or PSU delivering unclean power... but you'd probably 
see other errors in that case too.

-dean
