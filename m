Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbULHToi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbULHToi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbULHToi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:44:38 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:52098 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S261321AbULHTog
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:44:36 -0500
Subject: Re: Hard freeze with 2.6.10-rc3 and QoS, worked fine with 2.6.9
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Patrick McHardy <kaber@trash.net>
Cc: "David S. Miller" <davem@davemloft.net>, tgraf@suug.ch, akpm@osdl.org,
       tomc@compaqnet.fr, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <41B73263.4040706@trash.net>
References: <1102380430.6103.6.camel@buffy>
	 <20041206224441.628e7885.akpm@osdl.org>
	 <1102422544.1088.98.camel@jzny.localdomain> <41B5E188.5050800@trash.net>
	 <20041207170748.GF1371@postel.suug.ch> <41B5E722.2080600@trash.net>
	 <20041207213053.6bb602c1.davem@davemloft.net>
	 <1102507470.1051.27.camel@jzny.localdomain>  <41B73263.4040706@trash.net>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1102535069.1023.110.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 08 Dec 2004 14:44:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 11:57, Patrick McHardy wrote:
> jamal wrote:
> 
> >I can almost guarantee that one or more of those tests i outlined would
> >fail. So i would suggest a revert until the testing has been done.
> >
> Please be more specific than an "almost guarantee" that
> "one or more tests" may fail when asking to revert a patch
> that fixes an easily triggerable crash. For example, point
> to the code that makes you think it might fail.

I hope this is clear after you read the last email exchange i had with
Thomas and that you are not intentionaly trying to be annoying.

cheers,
jamal


