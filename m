Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTEIR7L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 13:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTEIR7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 13:59:11 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:33110 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S263375AbTEIR7J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 13:59:09 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <randy.dunlap@verizon.net>
In-Reply-To: <20030508122205.7b4b8a02.akpm@digeo.com>
References: <1052323940.2360.7.camel@diemos>
	 <1052336482.2020.8.camel@diemos> <20030507152856.2a71601d.akpm@digeo.com>
	 <1052402187.1995.13.camel@diemos>  <20030508122205.7b4b8a02.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052503920.2093.5.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 09 May 2003 13:12:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-08 at 14:22, Andrew Morton wrote:
> Can you pinpoint a kernel version at which it started to happen?

I have now isolated the latency problems further to 2.5.68-bk11

2.5.68-bk10 an earlier works fine.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


