Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbVCaBoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbVCaBoY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 20:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVCaBoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 20:44:24 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:34261 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262556AbVCaBoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 20:44:08 -0500
Subject: Re: 2.6.11, USB: High latency?
From: Lee Revell <rlrevell@joe-job.com>
To: David Brownell <david-b@pacbell.net>
Cc: kus Kusche Klaus <kus@keba.com>, stern@rowland.harvard.edu,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200503301740.49647.david-b@pacbell.net>
References: <200503301457.35464.david-b@pacbell.net>
	 <200503301728.09969.david-b@pacbell.net>
	 <1112232746.19975.41.camel@mindpipe>
	 <200503301740.49647.david-b@pacbell.net>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 20:44:03 -0500
Message-Id: <1112233444.19975.55.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 17:40 -0800, David Brownell wrote:
> This all seems off-topic for latency though.  :)
> 

Disagree, in the bug reports I saw from JACK users the symptoms are
exactly the same as a kernel latency problem.  The only clear hint that
it's something else is that the RT kernel and mainline are equally
affected.

Lee

