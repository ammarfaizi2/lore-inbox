Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbULHMEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbULHMEi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 07:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbULHMEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 07:04:38 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:58001 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S261191AbULHMEg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 07:04:36 -0500
Subject: Re: Hard freeze with 2.6.10-rc3 and QoS, worked fine with 2.6.9
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: "David S. Miller" <davem@davemloft.net>
Cc: Patrick McHardy <kaber@trash.net>, tgraf@suug.ch, akpm@osdl.org,
       tomc@compaqnet.fr, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20041207213053.6bb602c1.davem@davemloft.net>
References: <1102380430.6103.6.camel@buffy>
	 <20041206224441.628e7885.akpm@osdl.org>
	 <1102422544.1088.98.camel@jzny.localdomain> <41B5E188.5050800@trash.net>
	 <20041207170748.GF1371@postel.suug.ch> <41B5E722.2080600@trash.net>
	 <20041207213053.6bb602c1.davem@davemloft.net>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1102507470.1051.27.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 08 Dec 2004 07:04:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I can almost guarantee that one or more of those tests i outlined would
fail. So i would suggest a revert until the testing has been done.

cheers,
jamal

On Wed, 2004-12-08 at 00:30, David S. Miller wrote:
> On Tue, 07 Dec 2004 18:23:46 +0100
> Patrick McHardy <kaber@trash.net> wrote:
> 
> > Either one is fine with me, although I would prefer to see
> > the number of ifdefs in this area going down, not up :)
> 
> I agree, therefore I applied Patrick's patch.
> 

