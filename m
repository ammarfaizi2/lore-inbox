Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTITWQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 18:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTITWQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 18:16:28 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:2747 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261678AbTITWQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 18:16:27 -0400
Subject: Re: 2.4.2[12] v VIA Rhine and VIA82x audio (working with a fight)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux@treblig.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030920200922.GC8953@mail.jlokier.co.uk>
References: <20030920163835.GA723@gallifrey>
	 <1064079929.22995.7.camel@dhcp23.swansea.linux.org.uk>
	 <20030920200922.GC8953@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064096092.23121.1.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Sat, 20 Sep 2003 23:14:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-20 at 21:09, Jamie Lokier wrote:
> On a 2.5.75 kernel, I don't hear anything from the analogue input.

CMPCI in everything pre 2.4.22pre10-ac or so is obsolete and has all
sorts of problems with the later chips. C Tien of Cmedia sent a lot of
updates to the driver that were merged at that point.  I'd be interested
to know if you still have problems wiht that

