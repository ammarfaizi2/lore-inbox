Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270651AbTGUTIw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270653AbTGUTIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:08:52 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:46344 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S270651AbTGUTIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:08:47 -0400
Date: Mon, 21 Jul 2003 12:23:43 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: Re: Kernel 2.4 CPU Arch issues]
Message-ID: <20030721192343.GA5537@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3F1B25C2.8010403@jmu.edu> <1058745605.6299.4.camel@dhcp22.swansea.linux.org.uk> <3F1B32E6.4020107@jmu.edu> <1058769556.6977.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058769556.6977.2.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may cause mental anguish to the close-minded. Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 07:39:16AM +0100, Alan Cox wrote:
> On Llu, 2003-07-21 at 01:25, William M. Quarles wrote:
> > Well, wouldn't changing the gcc -march option and/or adding -mcpu 
> > options for the various processors in the Makefile make a difference, as 
> > the patchfile suggests?
> 
> Currently - no. gcc knows a lot more processor names that require individual
> unique optimisation

no && s/that/than/  


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
