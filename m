Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTEIVPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 17:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTEIVPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 17:15:49 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:1118 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S263467AbTEIVPs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 17:15:48 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <randy.dunlap@verizon.net>
In-Reply-To: <20030509140727.77d697cc.akpm@digeo.com>
References: <1052323940.2360.7.camel@diemos>
	 <1052336482.2020.8.camel@diemos> <20030507152856.2a71601d.akpm@digeo.com>
	 <1052402187.1995.13.camel@diemos> <20030508122205.7b4b8a02.akpm@digeo.com>
	 <1052503920.2093.5.camel@diemos>  <20030509140727.77d697cc.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052515722.2024.21.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 09 May 2003 16:28:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-09 at 16:07, Andrew Morton wrote:

> Well I'm darned if I can see a thing wrong there.  Are you using
> ieee1394, or USB, or any fancy networking features?

ieee1394 is disabled, pretty basic network options
(started from make defconfig)

See my reponse to Arnd Bergmann for more details.
I'm not thoroughly convinced it's USB either.
I'm still collecting info and testing different versions
to try and piece this together.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


