Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTJKCFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 22:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbTJKCFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 22:05:37 -0400
Received: from smtp.terra.es ([213.4.129.129]:41122 "EHLO tsmtp10.mail.isp")
	by vger.kernel.org with ESMTP id S263244AbTJKCFg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 22:05:36 -0400
Date: Sat, 11 Oct 2003 04:04:35 +0200
From: --- <grundig@teleline.es>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.7 "thoughts"] V0.3
Message-Id: <20031011040435.299bd3bc.grundig@teleline.es>
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be>
References: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 10 Oct 2003 09:54:12 +0200 "Frederick, Fabian" <Fabian.Frederick@prov-liege.be> escribió:

> 2.7 "thoughts"
> Thanks to Gabor, Stuart, Stephan and others
> Don't hesitate to send me more or comment.

On thing me (as a user) would like to see is more user limits.
In particular; a (small) per-user mlock limit would be nice so a normal user
can mlock some memory to avoid buffer underruns without needing to give suid
permissions to cdrecord (which is what people uses now and guarantees you'll
have to update your cdrecord copy some day due to unavoidable security issues).

I wonder if this is a good wishlist item or just a stupid idea...



Diego Calleja

