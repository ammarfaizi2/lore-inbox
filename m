Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272273AbTHRTUz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272242AbTHRTUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:20:55 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:17810 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S272273AbTHRTSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:18:31 -0400
Subject: Re: [PATCH] use simple_strtoul for unsigned kernel parameters
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: John Bradford <john@grabjohn.com>, torvalds@osdl.org, jamie@shareable.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20030818171554.GA32649@work.bitmover.com>
References: <200308181718.h7IHIUwU001800@81-2-122-30.bradfords.org.uk>
	 <20030818171554.GA32649@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061234270.25040.38.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 18 Aug 2003 20:17:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-08-18 at 18:15, Larry McVoy wrote:
> But who cares?  Nobody is going to run a Cray in their home for more than
> a few days, the power draw would get too expensive.  So this is well into
> "angels in the head of a pin" land.

If I remember rightly the ELC runs on a single phase with only one CPU
fitted


